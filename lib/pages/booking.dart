// Booking page
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:passtrack/colors.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:passtrack/pages/ticketdetails.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String busSvg = 'assets/images/busSvg.svg';
  String rightLeftSvg = 'assets/images/rightLeftSvg';

  final List<String> cities = ['Kigali', 'Muhanga', 'Huye', 'Musanze'];
  String? fromCity;
  String? toCity;

  void _swapCities() {
    setState(() {
      final temp = fromCity;
      fromCity = toCity;
      toCity = temp;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Dropdowns
            Container(
            decoration: BoxDecoration(
              color: mcgpalette0[50],
              border: Border(top: BorderSide(width: 1, color: Colors.grey[400]!), bottom: BorderSide.none, right: BorderSide.none, left: BorderSide.none)
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromCity,
                    hint: Text('\t\t\tFrom', style: TextStyle(color: Colors.grey[400])),
                    dropdownColor: mcgpalette0[50],
                    style: TextStyle(color: Colors.grey[200]),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        fromCity = newValue;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.compare_arrows_outlined, color: Colors.white),
                  onPressed: _swapCities,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toCity,
                    hint: Text('\t\t\tTo', style: TextStyle(color: Colors.grey[400])),
                    dropdownColor: mcgpalette0[50],
                    style: TextStyle(color: Colors.grey[200]),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        toCity = newValue;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white38,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.green[700],
                          ),
                          onPressed: () => print('Settings button pressed'),
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
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.directions_bus,
                          color: Colors.green,
                        ),
                        onPressed: () => print('Settings button pressed'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.directions_railway,
                          color: Colors.green,
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

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TicketDetailsPage(
                      ticketDetails: TicketDetails(
                        busName: "HYUNDAI UNIVERSE",
                        from: "Kigali",
                        to: "Muhanga",
                        date: "15-May-2025",
                        time: "9:00 AM",
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "HYUNDAI UNIVERSE",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Icon(
                                      Icons.navigation_outlined,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "From",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                      Text(
                                        "Kigali",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Text(
                                        "15-May-2025",
                                        style: TextStyle(fontSize: 11),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Destination",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                      Text(
                                        "Muhanga",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Text(
                                        "08-Dec-2024",
                                        style: TextStyle(fontSize: 11),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // second row  to shape a listtile - it can't have enough space in the display
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const DottedLine(
                            direction: Axis.vertical,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 3.0,
                            dashColor: Colors.grey,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("9:00 AM"),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(90, 10),
                                      backgroundColor: mcgpalette0[50]),
                                  onPressed: () {},
                                  child: const Text(
                                    "Buy Ticket",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  )),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                                child: RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                      text: "Price: ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
                                  TextSpan(
                                      text: "RWF3500",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 10)),
                                ])),
                              )
                              // Container(child: Text(),),
                            ],
                          ),
                        ],
                      ),
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
