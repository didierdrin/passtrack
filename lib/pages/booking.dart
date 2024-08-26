// Booking page
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/crowdmonitoring.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:passtrack/pages/ticketdetails.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:passtrack/components/ticket_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:passtrack/pages/sign.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool choice = false;
  bool choice2 = false;
  final logger = Logger();
  String busSvg = 'assets/images/busSvg.svg';
  String rightLeftSvg = 'assets/images/rightLeftSvg';

  final List<String> cities = ['Nyabugogo', 'Muhanga', 'Ruhango', 'Nyanza', 'Huye', 'Rusizi', 'Gasarenda', 'Nyamagabe', 'Kitabi', 'Pindura', 'Kibeho', 'Munege', 'Munini'];
  String? fromCity;
  String? toCity;

  void _swapCities() {
    setState(() {
      final temp = fromCity;
      fromCity = toCity;
      toCity = temp;
    });
  }

  void _filterTickets() {
    if (fromCity != null || toCity != null) {
      Provider.of<TicketProvider>(context, listen: false)
          .filterTickets(fromCity, toCity);
    } else {
      // If both are null, fetch all tickets
      Provider.of<TicketProvider>(context, listen: false).fetchTickets();
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch tickets when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketProvider>(context, listen: false).fetchTickets();
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
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.grey[400]!),
                      bottom: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide.none)),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.4),
                      child: DropdownButton<String>(
                        value: fromCity,
                        hint: Text('\t\t\tFrom',
                            style: TextStyle(color: Colors.grey[400])),
                        dropdownColor: mcgpalette0[50],
                        style: TextStyle(color: Colors.grey[200]),
                        isExpanded: true,
                        underline: Container(),
                        items: cities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            fromCity = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.compare_arrows_outlined,
                        color: Colors.white),
                    onPressed: _swapCities,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.4),
                      child: DropdownButton<String>(
                        value: toCity,
                        hint: Text('\t\t\tTo',
                            style: TextStyle(color: Colors.grey[400])),
                        dropdownColor: mcgpalette0[50],
                        style: TextStyle(color: Colors.grey[200]),
                        isExpanded: true,
                        underline: Container(),
                        items: cities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            toCity = newValue;
                          });
                        },
                      ),
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
                        onPressed: _filterTickets,
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
                        color: choice ? Colors.black : Colors.transparent,
                      ),
                      child: IconButton(
                          icon: const Icon(
                            Icons.directions_bus,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              choice = !choice;
                            });
                            logger.d('Choice bool changed! $choice');
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    
                    const Spacer(),
                    const Text("|"),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CrowdMonitoring()));
                      },
                      child: Container(
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
                    ),
                  ],
                ),
              ),
            ),

            Consumer<TicketProvider>(
              builder: (context, ticketProvider, child) {
                if (ticketProvider.tickets.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (ticketProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ticketProvider.tickets.length,
                  itemBuilder: (context, index) {
                    return _ticketCard(ticketProvider.tickets[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketCard(Ticket ticket) {
  final ticketProvider = Provider.of<TicketProvider>(context, listen: false);
  
  if (ticketProvider.isTicketExpired(ticket.departureTimestamp)) {
    return Container(); // Hide expired tickets
  }

  return InkWell(
    onTap: () {
      _handleTicketTap(ticket);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    ticket.busName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _routeInfo("From", ticket.routeFrom, ticketProvider.formatDepartureTime(ticket.departureTimestamp)),
                  const SizedBox(height: 10),
                  _routeInfo("To", ticket.routeTo, ticketProvider.formatExpirationTime(ticket.departureTimestamp)),
                ],
              ),
              const SizedBox(width: 5),
              const DottedLine(
                direction: Axis.vertical,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 3.0,
                dashColor: Colors.grey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(children: [
                    const SizedBox(width: 25,),
                    Text(ticketProvider.formatDepartureTime(ticket.departureTimestamp)),
                  ],),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(90, 10),
                      backgroundColor: mcgpalette0[50],
                    ),
                    onPressed: () {
                      _handleTicketTap(ticket);
                    },
                    child: const Text(
                      "Buy Ticket",
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Price: ",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          TextSpan(
                            text: "RWF${ticket.price.toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.teal, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Expires: ${ticketProvider.formatExpirationTime(ticket.departureTimestamp)}",
                    style: const TextStyle(color: Colors.red, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _routeInfo(String label, String location, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: label == "From" ? Colors.black : Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            label == "From" ? Icons.navigation_outlined : Icons.location_pin,
            color: label == "From" ? Colors.green : Colors.black,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            Text(
              location,
              style: const TextStyle(color: Colors.blue),
            ),
            SizedBox(
              width: 80,
              child: Text(
                date,
                style: const TextStyle(fontSize: 11),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleTicketTap(Ticket ticket) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, navigate to ticket details page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TicketDetailsPage(
            ticketDetails: TicketDetails(
              departure: ticket.departureTimestamp.toDate().toString(),
              price: ticket.price,
              busName: ticket.busName,
              from: ticket.routeFrom,
              to: ticket.routeTo,
              date: ticket.timeCreated.toDate().toString(),
              time:
                  "${ticket.timeCreated.toDate().hour}:${ticket.timeCreated.toDate().minute}",
            ),
          ),
        ),
      );
    } else {
      // User is not logged in, navigate to sign in page
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignInUp()),
      );
      if (result == true) {
        // User has successfully logged in, now navigate to ticket details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TicketDetailsPage(
              ticketDetails: TicketDetails( 
                departure: ticket.departureTimestamp.toDate().toString(),
                price: ticket.price,
                busName: ticket.busName,
                from: ticket.routeFrom,
                to: ticket.routeTo,
                date: ticket.timeCreated.toDate().toString(),
                time:
                    "${ticket.timeCreated.toDate().hour}:${ticket.timeCreated.toDate().minute}",
              ),
            ),
          ),
        );
      }
    }
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
