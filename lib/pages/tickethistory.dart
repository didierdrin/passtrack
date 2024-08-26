import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firebase Firestore
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/ticketinfo.dart';
import 'package:passtrack/components/tickethistory_provider.dart';
import 'package:provider/provider.dart';

class TicketHistoryPage extends StatefulWidget {
  const TicketHistoryPage({super.key});

  @override
  State<TicketHistoryPage> createState() => _TicketHistoryPageState();
}

class _TicketHistoryPageState extends State<TicketHistoryPage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketHistoryProvider>(context, listen: false)
          .fetchTicketHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Ticket History"),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSearchBar(),
          ),
          // Ticket list
          Expanded(
            child: Consumer<TicketHistoryProvider>(
              builder: (context, provider, child) {
                if (provider.tickets.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Filter tickets based on search query, ignoring purchaseDate
                final filteredTickets = provider.tickets.where((ticket) {
                  return ticket['name']
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()) ||
                      ticket['userName']
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());
                  // Exclude purchaseDate from the search filtering
                }).toList();

                return ListView.builder(
                  itemCount: filteredTickets.length,
                  itemBuilder: (context, index) {
                    final ticket = filteredTickets[index];
                    return _ticketTile(context, ticket);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search tickets...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }
}

// Modifying _ticketTile to exclude purchaseDate from the search criteria
Widget _ticketTile(BuildContext context, Map<String, dynamic> ticket) {
  return Card(
    elevation: 1,
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TicketInfo(ticket: ticket)),
        );
      },
      title: Text(ticket['name']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price: RWF ${ticket['price']}"),
          Text("Purchased: ${ticket['purchaseDate']}"), // purchaseDate is still displayed as a string
          Text("User: ${ticket['userName']}"),
        ],
      ),
    ),
  );
}
