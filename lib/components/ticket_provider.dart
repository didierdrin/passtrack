import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

class Ticket {
  final String id;
  final String busName;
  final GeoPoint from;
  final GeoPoint to;
  final double price;
  final String routeFrom;
  final String routeTo;
  final Timestamp timeCreated;
  final Timestamp departureTimestamp;
  final bool expired;

  Ticket({
    required this.id,
    required this.busName,
    required this.from,
    required this.to,
    required this.price,
    required this.routeFrom,
    required this.routeTo,
    required this.timeCreated,
    required this.departureTimestamp,
    required this.expired,
  });

  factory Ticket.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Ticket(
      id: doc.id,
      busName: data['bus_name'] ?? '',
      from: data['from'] ?? const GeoPoint(0, 0),
      to: data['to'] ?? const GeoPoint(0, 0),
      price: (data['price'] ?? 0).toDouble(),
      routeFrom: data['route_from'] ?? '',
      routeTo: data['route_to'] ?? '',
      timeCreated: data['time_created'] ?? Timestamp.now(),
      departureTimestamp: data['departure_timestamp'] ?? Timestamp.now(),
      expired: data['expired'] ?? false,
    );
  }
}

class TicketProvider with ChangeNotifier {
  final logger = Logger();
  List<Ticket> _tickets = [];
  bool _isLoading = false;

  List<Ticket> get tickets => _tickets;
  bool get isLoading => _isLoading;

  Future<void> fetchTickets() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tickets')
          .orderBy('departure_timestamp', descending: false)
          .get();
      _tickets = querySnapshot.docs.map((doc) => Ticket.fromFirestore(doc)).toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      logger.d('Error fetching tickets: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterTickets(String? fromCity, String? toCity) async {
    try {
      _isLoading = true;
      notifyListeners();

      Query query = FirebaseFirestore.instance.collection('tickets');
      
      if (fromCity != null) {
        query = query.where('route_from', isEqualTo: fromCity);
      }
      if (toCity != null) {
        query = query.where('route_to', isEqualTo: toCity);
      }

      QuerySnapshot querySnapshot = await query.get();
      _tickets = querySnapshot.docs.map((doc) => Ticket.fromFirestore(doc)).toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      logger.d('Error filtering tickets: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  String formatDepartureTime(Timestamp timestamp) {
    return DateFormat('HH:mm').format(timestamp.toDate());
  }

  String formatExpirationTime(Timestamp timestamp) {
    DateTime expirationTime = timestamp.toDate().add(const Duration(hours: 1));
    return DateFormat('HH:mm').format(expirationTime);
  }

  bool isTicketExpired(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime expirationTime = timestamp.toDate().add(const Duration(hours: 1));
    return now.isAfter(expirationTime);
  }
}