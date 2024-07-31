import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:passtrack/colors.dart';

class Reminder {
  final String id;
  final String title;
  final DateTime date;
  final bool isCompleted;

  Reminder(
      {required this.id,
      required this.title,
      required this.date,
      this.isCompleted = false});
}

class PlanToPage extends StatefulWidget {
  const PlanToPage({super.key});

  @override
  State<PlanToPage> createState() => _PlanToPageState();
}

class _PlanToPageState extends State<PlanToPage> {
  List<Reminder> reminders = [];
  String searchQuery = '';
  String filterValue = 'All';
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    tz.initializeTimeZones();
    // Mock data
    reminders = [
      Reminder(
          id: '1',
          title: 'Nyabugogo > Muhanga',
          date: DateTime.now().add(const Duration(days: 1))),
      Reminder(
          id: '2',
          title: 'Muhanga > Rusizi',
          date: DateTime.now().add(const Duration(days: 2))),
      Reminder(
          id: '3', title: 'Rusizi > Nyabugogo', date: DateTime.now(), isCompleted: true),
    ];
  }

  Future<void> initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(Reminder reminder) async {
    // Replace with your desired schedule mode
    const AndroidScheduleMode scheduleMode = AndroidScheduleMode.exact;
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminder Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(reminder.id),
      'Reminder: ${reminder.title}',
      'It\'s time for your reminder!',
      tz.TZDateTime.from(reminder.date, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: scheduleMode,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Plan-To"),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterDropdown(),
          Expanded(
            child: _buildReminderList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search reminders...',
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

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButton<String>(
        isExpanded: true,
        value: filterValue,
        items: ['All', 'Today', 'Scheduled', 'Completed', 'Saved']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              filterValue = newValue;
            });
          }
        },
      ),
    );
  }

  Widget _buildReminderList() {
    final filteredReminders = reminders.where((reminder) {
      if (searchQuery.isNotEmpty &&
          !reminder.title.toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      switch (filterValue) {
        case 'Today':
          return reminder.date.day == DateTime.now().day;
        case 'Scheduled':
          return !reminder.isCompleted && reminder.date.isAfter(DateTime.now());
        case 'Completed':
          return reminder.isCompleted;
        case 'Saved':
          return !reminder.isCompleted;
        default:
          return true;
      }
    }).toList();

    return ListView.builder(
      itemCount: filteredReminders.length,
      itemBuilder: (context, index) {
        final reminder = filteredReminders[index];
        return ListTile(
          title: Text(reminder.title),
          subtitle: Text(reminder.date.toString()),
          trailing: Checkbox(
            value: reminder.isCompleted,
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  reminders[reminders.indexWhere((r) => r.id == reminder.id)] =
                      Reminder(
                          id: reminder.id,
                          title: reminder.title,
                          date: reminder.date,
                          isCompleted: value);
                });
                if (value) {
                  flutterLocalNotificationsPlugin
                      .cancel(int.parse(reminder.id));
                } else {
                  scheduleNotification(reminder);
                }
              }
            },
          ),
        );
      },
    );
  }

  void _showAddReminderDialog() {
    final titleController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Reminder Title'),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 30)),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: const Text('Select Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final newReminder = Reminder(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    date: selectedDate,
                  );
                  setState(() {
                    reminders.add(newReminder);
                  });
                  scheduleNotification(newReminder);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
