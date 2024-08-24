import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _settingsTile("Language", "US | FR | RW"),
            _settingsTile("Notifications", "Turn on/off"),
            _settingsTile("Contact Us", "Feel free to reach us"),
            _settingsTile("My Account", "Change personal details"),
            //_notificationTile(),
          ],
        ),
      ),
    );
  }
}

Widget _settingsTile(titleTxt, subtitleTxt) {
  return Card(
    elevation: 1,
    child: ListTile(
    title: Text(titleTxt),
    subtitle: Text(subtitleTxt),
  ),
  );
}
