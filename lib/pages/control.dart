// Control Page
import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/help.dart';
import 'package:passtrack/pages/notifications.dart';
import 'package:passtrack/pages/settings.dart';
import 'package:passtrack/pages/tickethistory.dart';
import 'package:passtrack/components/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passtrack/pages/weatherforecast.dart';
// Page imports
import 'home.dart';
import 'booking.dart';
import 'promotions.dart';
import 'profile.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  String imgSample = "assets/images/volicon.png";
  String _title = "Home";
  static int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
  }

  final PageController _pageController =
      PageController(initialPage: _pageIndex);

  List<Widget> _fourPageViewChildren() {
    return <Widget>[
      const HomePage(),
      const BookingPage(),
      const PromotionsPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: Text(_title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpPage()));
              },
              icon: const Icon(Icons.chat)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NotificationsPage()));
              },
              icon: const Icon(Icons.notifications)),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.close_outlined,
                                color: Colors.redAccent,
                              )),
                        ),
                        ListTile(
                          leading: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset(imgSample),
                          ),
                          title: StreamBuilder<User?>(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                // User is logged in
                                return SizedBox(
                                  width: 70,
                                  child: Text(
                                    snapshot.data!.email ?? "User",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: mcgpalette0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              } else {
                                // User is not logged in
                                return const Text(
                                  "Guest User",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: mcgpalette0,
                                  ),
                                );
                              }
                            },
                          ),
                          subtitle: StreamBuilder<User?>(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.hasData ? "Active Now" : "Logged Out",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              );
                            },
                          ),
                          onTap: () {
                            // Your onTap logic here
                          },
                        ),
                      ]),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TicketHistoryPage()));
                },
                leading: const Icon(Icons.history_rounded),
                title: const Text("Ticket History"), // Order History
              ),
              const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WeatherForecastPage()));
                },
                leading: const Icon(Icons.wb_sunny_outlined),
                title: const Text("Weather Forecast"), // Weather Forecast
              ),
              const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HelpPage()));
                },
                leading: const Icon(Icons.help_outline),
                title: const Text("Help"), // Order History
              ),
              const Divider(
                thickness: 1,
                endIndent: 20,
                indent: 20,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()));
                },
                leading: const Icon(Icons.settings_outlined),
                title: const Text("Settings"),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Log Out"),
                onTap: () {
                  AuthService().signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _pageIndex = index;
            switch (_pageIndex) {
              case 0:
                {
                  _title = 'Home';
                }
                break;
              case 1:
                {
                  _title = 'Bookings';
                }
                break;
              case 2:
                {
                  _title = 'Promotions';
                }
                break;
              case 3:
                {
                  _title = 'Profile';
                }
                break;
            }
          });
        },
        children: _fourPageViewChildren(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount), label: "Promotions"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (int index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
        },
        unselectedItemColor: Colors.black,
        currentIndex: _pageIndex,
        selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          color: Colors.black45,
        ),
      ),
    );
  }
}
