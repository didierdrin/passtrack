import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TicketHistoryProvider with ChangeNotifier {
  final logger = Logger();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> _tickets = [];

  List<Map<String, dynamic>> get tickets => _tickets;

  Future<void> fetchTicketHistory() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final querySnapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('tickethistory')
            .get();

        _tickets = querySnapshot.docs.map((doc) {
          final data = doc.data();
          final ticketDetails = data['ticketdetails'] as Map<String, dynamic>;
          final userDetails = data['userdetails'] as Map<String, dynamic>;

          return {
            'name': ticketDetails['name'] as String,
            'price': ticketDetails['price'] as num,
            'purchaseDate':
                (ticketDetails['purchaseDate'] as Timestamp).toDate(),
            'userName': userDetails['name'] as String,
          };
        }).toList();

      
      // normal codes of this page

        notifyListeners();
      }
    } catch (e) {
      logger.d('Error fetching ticket history: $e');
    }
  }
}
