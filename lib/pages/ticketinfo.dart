import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:qr_flutter/qr_flutter.dart'; // Import the qr_flutter package
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show MapType;
import 'package:intl/intl.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TicketInfo extends StatefulWidget {
  final Map<String, dynamic> ticket;

  const TicketInfo({super.key, required this.ticket});

  @override
  State<TicketInfo> createState() => _TicketInfoState();
}

class _TicketInfoState extends State<TicketInfo> {
  String formatTime(String dateTimeString) {
    DateTime dateTime =
        DateTime.parse(dateTimeString); // Parse the string into DateTime
    return DateFormat('HH:mm')
        .format(dateTime); // Format to only show hours and minutes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Ticket Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _ticketInfo(context),
            ],
          ),
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              "${widget.ticket['route_from']}",
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(
              Icons.directions_bus_outlined,
              color: Colors.white,
            ),
            Text(
              "${widget.ticket['route_to']}",
              style: const TextStyle(color: Colors.white),
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
                  "DEPARTURE",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                Text(
                  formatTime(widget.ticket["departure"]),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "PASSENGER",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    "${widget.ticket['userName']}",
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Text(
                  "Bus PlateNo:",
                  style: TextStyle(color: Colors.grey[500]!),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    "${widget.ticket['name']}",
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
                const SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MapPage(
                          routeFrom: widget.ticket['route_from'],
                          routeTo: widget.ticket['route_to'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 85,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target:
                                    LatLng(-1.9412, 30.044), // Default location
                                zoom: 12,
                              ),
                              markers: {
                                const Marker(
                                  markerId: MarkerId('preview'),
                                  position: LatLng(
                                      -1.9412, 30.044), // Based on ticket data
                                ),
                              },
                              zoomGesturesEnabled: false,
                              scrollGesturesEnabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(
                          child: Icon(Icons.arrow_right),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "DURATION",
                //   style: TextStyle(color: Colors.grey[500]!),
                // ),
                // const Text(
                //   "2hr 41min",
                //   style: TextStyle(color: Colors.white),
                // ),
                // const SizedBox(
                //   height: 2,
                // ),
                // Text(
                //   "DISTANCE",
                //   style: TextStyle(color: Colors.grey[500]!),
                // ),
                // const Text(
                //   "106 KM",
                //   style: TextStyle(color: Colors.white),
                // ),
                // const SizedBox(
                //   height: 2,
                // ),
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
          _buildQrCode(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildQrCode() {
    if (widget.ticket['qrData'] == null) {
      return const CircularProgressIndicator();
    }

    return QrImageView(
      data: widget.ticket['qrData']!,
      version: QrVersions.auto,
      size: 150.0,
      backgroundColor: Colors.white,
      dataModuleStyle: const QrDataModuleStyle(
        color: Colors.blue,
      ),
    );
  }
}
