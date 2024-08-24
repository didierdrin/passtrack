// ignore_for_file: non_constant_identifier_names

import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passtrack/pages/tickethistory.dart';

class MomoPage extends StatefulWidget {
  final String? name;
  final String? email;
  final double? price;
  final String? route_from;
  final String? route_to;
  const MomoPage(
      {super.key,
      required this.name,
      required this.email,
      required this.price,
      required this.route_from,
      required this.route_to});
  @override
  State<MomoPage> createState() => _MomoPageState();
}

class _MomoPageState extends State<MomoPage> {
  final logger = Logger();
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  bool isTestMode = true;

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
    currencyController.text = selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("MomoPay"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              /*
              Container( 
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Amount"),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Amount is required",
                ),
              ),*/
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: currencyController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: _openBottomSheet,
                  decoration: const InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Currency is required",
                ),
              ),
              /*
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ), */
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  children: [
                    const Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isTestMode = value;
                        })
                      },
                      value: isTestMode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mcgpalette0,
                  ),
                  onPressed: _onPressed,
                  child: const Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() async {
    final currentState = formKey.currentState;
    if (currentState != null && currentState.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    User? user = FirebaseAuth.instance.currentUser;
    final Customer customer =
        Customer(email: user!.email ?? "customer@passtrack.com");

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-0ecb93e6c52b1c1c7625b9368f4992af-X",
        currency: selectedCurrency,
        redirectUrl: 'https://facebook.com',
        txRef: const Uuid().v1(),
        amount: (widget.price).toString(), // amountController.text.toString(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Make Payment"),
        isTestMode: isTestMode);
    final ChargeResponse response = await flutterwave.charge();
    if (response.status == "successful") {
      // Show payment confirmation dialog
      showLoading(response.toString());

      // Send ticket details to Firestore
      //await sendTicketDetailsToFirestore(widget.name, widget.price);

      _navigateToConfirmPage();
    } else {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      showLoading(response.toString());
      logger.d('Card payment failed');
      scaffoldMessenger.showSnackBar(
        SnackBar(
          // Combine label and content into a single Row for top alignment
          content: const Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align content horizontally
            children: [
              Text(
                  "Payment failed\nReason: Card declined"), // Short text at the end
              Flexible(
                // Makes label text wrap if needed
                child: SizedBox(
                  width: 100,
                  child: Text(
                    "",
                    style:
                        TextStyle(fontSize: 14), // Adjust font size as needed
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
    //showLoading(response.toString());
    //logger.d("${response.toJson()}");
  }

  void _navigateToConfirmPage() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    logger.d('Momo payment successful: Successful');
    // Send ticket details to Firestore Card Payment 1
    await sendTicketDetailsToFirestore(
        widget.name!, widget.price!, widget.route_from!, widget.route_to!);

    // Navigate to ConfirmPage and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmPage(
          name: widget.name!,
          price: widget.price!,
        ),
      ),
      (route) => false, // This will remove all previous routes
    );

    scaffoldMessenger.showSnackBar(
      SnackBar(
        // Combine label and content into a single Row for top alignment
        content: const Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align content horizontally
          children: [
            Text("Payment executed\nsuccessfully!"), // Short text at the end
            Flexible(
              // Makes label text wrap if needed
              child: SizedBox(
                width: 100,
                child: Text(
                  "",
                  style: TextStyle(fontSize: 14), // Adjust font size as needed
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        action: SnackBarAction(
          label: "Find your ticket",
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const TicketHistoryPage()));
            // Navigator.pop(context);
          }, // On-click action
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["RWF"]; // ["UGX", "KES", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {_handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
