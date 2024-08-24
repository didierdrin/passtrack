import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Notification {
  final String id;
  final String title;
  final String subtitle;
  final Timestamp timestamp;

  Notification({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });

  factory Notification.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Notification(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Notifications"),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: _buildSearchBar(),
          // ),
          Expanded(
            child: _buildNotificationList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search notifications...',
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
    );
  }

  Widget _buildNotificationList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('notifications').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Notification> notifications = snapshot.data!.docs
            .map((doc) => Notification.fromFirestore(doc))
            .where((notification) {
          return notification.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              notification.subtitle.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return _notificationTile(notifications[index]);
          },
        );
      },
    );
  }

  Widget _notificationTile(Notification notification) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Text(notification.title),
          //const SizedBox(width: 8,),
          SizedBox(width: 120, child: Text(overflow: TextOverflow.ellipsis,DateFormat('yyyy-MM-dd HH:mm').format(notification.timestamp.toDate()))),
        ],),
        subtitle: Text(notification.subtitle),
    
        onTap: () => _showNotificationDetails(notification),
      ),
    );
  }

  void _showNotificationDetails(Notification notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(notification.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(notification.subtitle),
              const SizedBox(height: 10),
              Text('Date: ${DateFormat('yyyy-MM-dd HH:mm').format(notification.timestamp.toDate())}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}