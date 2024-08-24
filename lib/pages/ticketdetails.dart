// TicketDetails

import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/paymentoptions.dart';

class TicketDetailsPage extends StatefulWidget {
  final TicketDetails ticketDetails; // Replace with your ticket details object

  const TicketDetailsPage({super.key, required this.ticketDetails});

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  // Add a variable to store the selected seat (e.g., "C1")
  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Ticket Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display ticket information (from widget.ticketDetails)
              Text(
                'Bus: ${widget.ticketDetails.busName}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('From: ${widget.ticketDetails.from}'),
                  Text('To: ${widget.ticketDetails.to}'),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 140,
                      child: Text(
                        'Date: ${widget.ticketDetails.date}',
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('Time: ${widget.ticketDetails.time}'),
                ],
              ),
              const SizedBox(height: 20.0),
              Divider(
                thickness: 1,
                color: Colors.green[200],
              ),
              const SizedBox(height: 20.0),
              const Text('Select Seat:'),
              const SizedBox(height: 10.0),
              _buildSeatSelectionGrid(),
              const SizedBox(height: 20.0),
              ElevatedButton(
          
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.black,
                ),
                onPressed:
                    selectedSeat != null ? () => _onBuyTicketPressed() : null,
                child: const Text('Buy Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatSelectionGrid() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green[200]!),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        crossAxisCount: 4,
        children: List.generate(32, (index) {
          final row = (index ~/ 4) + 1;
          final col = index % 4 + 1;
          final seatId = '$col$row';

          return InkWell(
            onTap: () => setState(() => selectedSeat = seatId),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: selectedSeat == seatId
                    ? Border.all(color: Colors.green, width: 2.0)
                    : null,
              ),
              child: Center(
                child: Text(seatId),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _onBuyTicketPressed() {
    // Implement logic to handle seat selection and ticket purchase
    //  (e.g., navigate to payment screen or show confirmation dialog)
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PaymentOptions(
                  name: widget.ticketDetails.busName,
                  route_from: widget.ticketDetails.from,
                  route_to: widget.ticketDetails.to,
                  price: widget.ticketDetails.price,
                )));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seat $selectedSeat selected!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class TicketDetails {
  final String busName;
  final String from;
  final String to;
  final String date;
  final String time;
  final double price;

  TicketDetails({
    required this.busName,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
  });
}
