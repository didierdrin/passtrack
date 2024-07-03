// Booking page
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:passtrack/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String busSvg = 'assets/images/busSvg.svg';
  static var rightLeftSvg = 'assets/images/rightLeftSvg'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: mcgpalette0[50],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[200]),
                      decoration: InputDecoration(
                        hintText: 'From',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SvgPicture.asset(rightLeftSvg),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[200]),
                      decoration: InputDecoration(
                        hintText: 'To',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                color: Colors.grey[200], // Simulate app bar background color
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green),
                      child: IconButton(
                        icon: const Icon(
                          Icons.bus_alert,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.railway_alert,
                          color: Colors.grey[700],
                        ),
                        onPressed: () => print('Settings button pressed'),
                      ),
                    ),
                    const Spacer(),
                    const Text("|"),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: mcgpalette0[50]),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                            child: Text(
                          "Crowd Monitoring",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Adjust the corner radius
                ),
                child: ClipPath(
                  clipper: null, //SemiCircleClipper(),
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(10.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "HYUNDAI UNIVERSE",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        DottedLine(
                          direction: Axis.vertical,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 3.0,
                          dashColor: Colors.grey,
                        ),
                        Column(
                          children: [
                            Text("9:00 AM"),
                            // Container(child: Text(),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // const Center(child: Text("No Booked Tickets")),
          ],
        ),
      ),
    );
  }
}

class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.height / 2; // Adjust the radius as needed

    path.moveTo(centerX - radius, centerY);
    path.arcToPoint(
      Offset(centerX + radius, centerY),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
