// Control Page
import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

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
  String imgSample = "assets/images/imgSample.png";
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
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
                            child: Image.asset(imgSample
                                //"${FirebaseAuth.instance.currentUser!.photoURL}",
                                ),
                          ),
                          title: const Text(
                            "Didier Codeseal",
                            //"${FirebaseAuth.instance.currentUser!.displayName}",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: mcgpalette0),
                          ),
                          subtitle: const Text(
                            "Active Now"
                            /*
                            FirebaseAuth.instance.currentUser != null
                                ? "Active Now"
                                : "Logged Out" */
                            ,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          //trailing: const Icon(Icons.cancel_outlined),
                          onTap: () {
                            /*
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => ControlPage(
                                        customIndex:
                                            FirebaseAuth.instance.currentUser ==
                                                    null
                                                ? 3
                                                : 0,
                                      )),
                            ); */
                          },
                        ),
                      ]),
                ),
              ),
              ListTile(
                onTap: () {
                  /*
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CartPage(
                              name: "Cart List",
                              imgUrl: "Cart item from list",
                              price: "State Management - GetX"))); */
                },
                leading: const Icon(Icons.wb_sunny_outlined),
                title: const Text("Weather Forecast"), // Order History
              ),
              const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                onTap: () {
                  //Navigator.push(context,MaterialPageRoute(builder: (_) => const HelpPage()));
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
                  //Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpPage()));
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
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
                },
                leading: const Icon(Icons.settings_outlined),
                title: const Text("Settings"),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Sign Out"),
                onTap: () {
                  // AuthService().signOut();
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
