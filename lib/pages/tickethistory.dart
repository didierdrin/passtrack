import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/ticketinfo.dart';
import 'package:passtrack/components/tickethistory_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  State<TicketHistoryPage> createState() => _TicketHistoryPageState();
}

class _TicketHistoryPageState extends State<TicketHistoryPage> {
  @override
  void initState() {
    super.initState();
    // Fetch tickets when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketHistoryProvider>(context, listen: false).fetchTicketHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Ticket History"),
      ),
      body: Consumer<TicketHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.tickets.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ticket = provider.tickets[index];
                    return _ticketTile(context, ticket);
                  },
                  childCount: provider.tickets.length,
                ),
              ),
              // You can add more slivers here if needed
            ],
          );
        },
      ),
    );
  }
}

Widget _ticketTile(BuildContext context, Map<String, dynamic> ticket) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  return Card(
    elevation: 1,
    child: ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => TicketInfo(ticket: ticket)));
      },
      title: Text(ticket['name']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price: RWF ${ticket['price']}"),
          Text("Purchased: ${formatter.format(ticket['purchaseDate'])}"),
          Text("User: ${ticket['userName']}"),
        ],
      ),
    ),
  );
}
