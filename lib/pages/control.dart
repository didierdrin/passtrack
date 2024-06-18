// Control Page
import 'package:flutter/material.dart';

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
        title: Text(_title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
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
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.discount), label: "Promotions"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (int index) {
          _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
        },
        unselectedItemColor: Colors.black,
        currentIndex: _pageIndex,
        selectedItemColor: Colors.green,
      ),
    );
  }
}
