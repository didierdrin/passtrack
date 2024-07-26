import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
            _notificationTile(),
            //_notificationTile(),
          ],
        ),
      ),
    );
  }
}

Widget _notificationTile() {
  return const Card(
    elevation: 1,
    child: ListTile(
    title: Text("Updates"),
    subtitle: Text("Add your details in profile settings to level up your account."),
  ),
  );
}
