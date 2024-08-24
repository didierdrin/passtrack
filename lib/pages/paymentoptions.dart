// Payment Options - "Checkout button from CartPage navigate here".
// ignore_for_file: non_constant_identifier_names

import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:passtrack/pages/confirm.dart';
import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
// import 'package:bkni/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passtrack/pages/tickethistory.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'momo.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions(
      {super.key,
      required this.name,
      required this.price,
      required this.route_from,
      required this.route_to});

  final String name;
  final double price;
  final String route_from;
  final String route_to;
  @override
  State<PaymentOptions> createState() => _PaymentOptions();
}

class _PaymentOptions extends State<PaymentOptions> {
  final logger = Logger();
  final int _counter = 0;
  final String imageVector = "assets/images/img_vector.svg";
  // For Payments
  final String paypallogo = "assets/images/logos_paypalpaypal logo svg.svg";
  final String paypalname = "assets/images/fontisto_paypalpaypalsvg.svg";
  final String cardsvg = "assets/images/ion_card-outlinecardsvg.svg";
  final String mtnlogo = "assets/images/mtn.png";

  Future<void> sendTicketDetailsToFirestore(
      String name, double price, String route_from, String route_to) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a reference to the user's tickethistory collection
        CollectionReference ticketHistory = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tickethistory');

        // Add a new document with a generated ID
        await ticketHistory.add({
          'ticketdetails': {
            'name': name,
            'price': price,
            'route_from': route_from,
            'route_to': route_to,
            'purchaseDate': FieldValue.serverTimestamp(),
          },
          'userdetails': {
            'name': user.email ?? 'Unknown',
          },
        });

        // Create a reference to the totalpurchases collection
        CollectionReference totalPurchases =
            FirebaseFirestore.instance.collection('totalpurchases');

        await totalPurchases.add({
          'name': name,
          'price': price,
          'route_from': route_from, 
          'route_to': route_to,
          'purchaseDate': FieldValue.serverTimestamp(),
        });

        logger.d('Ticket details sent to Firestore successfully');
      } else {
        logger.e('No user is currently signed in');
      }
    } catch (e) {
      logger.e('Error sending ticket details to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Choose Payment Method"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              // Order Total
              Container(
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green, // const Color(0xFF616161),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ticket total",
                            style: TextStyle(color: Color(0xFFFFFFFF))),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "No Coupons \n$_counter% OFF",
                          style: const TextStyle(color: Color(0xFF616161)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // Image Section
                    Center(
                      child: Text("RWF ${widget.price}",
                          style: const TextStyle(
                              fontSize: 18, color: Color(0xFFFFFFFF))),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recommended",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        final request = BraintreeDropInRequest(
                          tokenizationKey: "sandbox_fwc29vc6_nr2dhwmg7vgqfw94",
                          collectDeviceData: true,
                          cardEnabled: true,
                        );
                        BraintreeDropInResult? result =
                            await BraintreeDropIn.start(request);
                        if (result != null) {
                          logger.d('Card payment successful: $result');
                          // Send ticket details to Firestore Card Payment 1
                          await sendTicketDetailsToFirestore(widget.name,
                              widget.price, widget.route_from, widget.route_to);

                          // Navigate to ConfirmPage and remove all previous routes
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConfirmPage(
                                name: widget.name,
                                price: widget.price,
                              ),
                            ),
                            (route) =>
                                false, // This will remove all previous routes
                          );

                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              // Combine label and content into a single Row for top alignment
                              content: const Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Align content horizontally
                                children: [
                                  Text(
                                      "Payment executed\nsuccessfully!"), // Short text at the end
                                  Flexible(
                                    // Makes label text wrap if needed
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                14), // Adjust font size as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.greenAccent,
                              action: SnackBarAction(
                                label: "Find your ticket",
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const TicketHistoryPage()));
                                  // Navigator.pop(context);
                                }, // On-click action
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          logger.d('Card payment failed');
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              // Combine label and content into a single Row for top alignment
                              content: const Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Align content horizontally
                                children: [
                                  Text(
                                      "Payment failed\nReason: Card declined"), // Short text at the end
                                  Flexible(
                                    // Makes label text wrap if needed
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            fontSize:
                                                14), // Adjust font size as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.redAccent,
                              action: SnackBarAction(
                                label: "Choose Payment Option",
                                onPressed: () {
                                  // Navigator.pop(context);
                                }, // On-click action
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Card(
                        elevation: 1.0,
                        color: Colors.white,
                        child: Container(
                          width: 120,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                    cardsvg,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Card Payment",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Visa, MasterCard",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Momo Payment

                    InkWell(
                      onTap: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MomoPage(
                                      email: user!.email,
                                      price: widget.price,
                                      name: widget.name,
                                      route_from: widget.route_from,
                                      route_to: widget.route_to,
                                    )));

                        // Send ticket details to Firestore Card Payment 1
                        // await sendTicketDetailsToFirestore(
                        //     widget.name, widget.price, widget.route_from, widget.route_to);
                      },
                      child: Card(
                        elevation: 1.0,
                        color: Colors.white,
                        child: Container(
                          width: 120,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(mtnlogo),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "MomoPay",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "MTN",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
