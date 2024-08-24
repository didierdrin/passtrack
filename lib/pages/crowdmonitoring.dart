import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class CrowdMonitoring extends StatefulWidget {
  const CrowdMonitoring({super.key});

  @override
  State<CrowdMonitoring> createState() => _CrowdMonitoringState();
}

class _CrowdMonitoringState extends State<CrowdMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Crowd Monitoring"),
      ), 

      body: SingleChildScrollView(
        child: Column(
          children: [
            _crowdTile(),
            //_notificationTile(),
          ],
        ),
      ),
    );
  }
}

Widget _crowdTile() {
  return const Card(
    elevation: 1,
    child: ListTile(
    title: Text("Bus Name: RAB987Q"),
    subtitle: Text("Add your details in profile settings to level up your account."),
  ),
  );
}
