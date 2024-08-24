import 'package:flutter/material.dart';
import 'package:passtrack/firebase_options.dart';
//import 'package:passtrack/pages/home.dart';
import 'package:passtrack/welcome.dart';
import 'pages/control.dart';
import 'colors.dart';
import 'package:provider/provider.dart';
import 'package:passtrack/components/post_provider.dart';
import 'package:passtrack/components/ticket_provider.dart';
import 'package:passtrack/components/tickethistory_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => TicketProvider()),
        ChangeNotifierProvider(create: (_) => TicketHistoryProvider()),
      ],
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch; 
  const MyApp({super.key, required this.isFirstLaunch});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volcano Express',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: mcgpalette0[50]!),
        useMaterial3: true,
      ),
      home: isFirstLaunch ? const WelcomePage() : const ControlPage(),
    );
  }
}
