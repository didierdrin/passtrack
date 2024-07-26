import 'package:flutter/material.dart';
import 'package:passtrack/firebase_options.dart';
import 'pages/control.dart';
import 'colors.dart';
import 'package:provider/provider.dart';
import 'package:passtrack/components/post_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const ControlPage(),
    );
  }
}
