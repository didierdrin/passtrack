import 'package:passtrack/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passtrack/pages/tickethistory.dart';
// imports
// import 'package:flutter_svg/flutter_svg.dart';
// import 'notifications.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage(
      {super.key,
      required this.name,
      required this.imgUrl,
      required this.price});
  final String name;
  final String imgUrl;
  final String price;
  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final String imageVector = "assets/images/img_vector.svg";
  final String checkIcon = "assets/images/Check--Streamline-Core.svg";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Payment Confirmation"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Products Cart List
            
            // Success
            Column(
              children: [
                Center(
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[50],
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50.0,
                    left: 50.0,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[100],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 25.0,
                    left: 25.0,
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[200],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50.0,
                    left: 50.0,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[300],
                      ),
                      child: Center(child: SvgPicture.asset(checkIcon, fit: BoxFit.cover, height: 30, width: 30,),),
                    ),
                  ),

                ],),),),),
                
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Center(child: Text("Payment Successful", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 25.0, bottom: 20.0),
                  child: SizedBox(width: 200, child: Center(
                    child: Text(
                        "Total amount paid by VisaCard. Please, help us with our product reviews via Email.", style: TextStyle(fontSize: 10),),
                  ),),
                ),
              ],
            ),
            // Total
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 124,
                decoration: BoxDecoration(
                  color: mcgpalette0[50],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Blue Shoes"),
                          Text("RWF30,000"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Exclusive Tee"),
                          Text("RWF35,000"),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(10.0), child: Divider(),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total"),
                          Text("RWF65,000"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TicketHistoryPage()));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color(0xFF159954),
            ),
            child: const Text(
              "Proceed to Ticket History",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    );
  }
}
