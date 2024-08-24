import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
//import 'package:passtrack/components/ticket_provider.dart';
import 'package:passtrack/pages/map.dart';

class TicketInfo extends StatefulWidget {
  final Map<String, dynamic> ticket;

  const TicketInfo({super.key, required this.ticket});

  @override
  State<TicketInfo> createState() => _TicketInfoState();
}

class _TicketInfoState extends State<TicketInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Ticket Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            _ticketInfo(context),
          ],
        ),
      ),
    );
  }

Widget _ticketInfo(BuildContext context) {
  return Card(
      color: const Color(0xff234665),
      elevation: 1,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Volcano Express",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          ),
          const Divider(
            thickness: 1.0,
            endIndent: 10,
            indent: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Kigali",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.directions_bus_outlined,
                  color: Colors.white,
                ),
                Text(
                  "Musanze",
                  style: TextStyle(color: Colors.white),
                ),
              ]),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BOARDS",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                const Text(
                  "01:00 PM",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "PASSENGER",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                Text(
                   "${widget.ticket['userName']}",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Text(
                  "Ticket ID: 2342",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
              SizedBox( 
                width: 100,
                child: Text(
                    "${widget.ticket['purchaseDate']}",
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
              ),
              ],
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ROUTE",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                const SizedBox(height: 4,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const MapPage()));
                  },
                  child: Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DURATION",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                const Text(
                  "2hr 41min",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "DISTANCE",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                const Text(
                  "106 KM",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "SEAT",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                const Text(
                  "A5",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Redeemed:\n${widget.ticket['purchaseDate']}",
            style: TextStyle(color: Colors.grey[400]!),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 2,
          ),
          const Icon(
            Icons.qr_code,
            size: 90,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ));
}



}


