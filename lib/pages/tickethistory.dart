import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/ticketinfo.dart';

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
        title: const Text("Ticket History"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ticketTile(context),
            //_notificationTile(),
          ],
        ),
      ),
    );
  }
}

Widget _ticketTile(BuildContext context) {
  return Card(
    elevation: 1,
    child: ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TicketInfo()));
      },
      title: const Text("Nyabugogo > Muhanga"),
      subtitle: const Text("Price: RWF 1,030"),
    ),
  );
}
