import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  State<TicketHistoryPage> createState() => _TicketHistoryPageState();
}

class _TicketHistoryPageState extends State<TicketHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Notifications"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ticketTile(),
            //_notificationTile(),
          ],
        ),
      ),
    );
  }
}

Widget _ticketTile() {
  return const Card(
    elevation: 1,
    child: ListTile(
    title: Text("Nyabugogo > Muhanga"),
    subtitle: Text("Price: RWF 1,030"),
  ),
  );
}
