import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class TicketInfo extends StatefulWidget {
  const TicketInfo({super.key});

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
} 

Widget _ticketInfo(BuildContext context) {
  return Card(
    color: const Color(0xff234665),
    elevation: 1,
    child: Column(children: [
      const SizedBox(height: 15,),
      const Text("Volcano Express", textAlign: TextAlign.left, style: TextStyle(color: Colors.white),), 
      const Divider(thickness: 1.0, endIndent: 10, indent: 10,),
      ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TicketInfo()));
      },
      title: const Text("Nyabugogo > Muhanga", style: TextStyle(color: Colors.white),),
      subtitle: const Text("Price: RWF 1,030", style: TextStyle(color: Colors.white),),
    ),

    ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const TicketInfo()));
      },
      title: const Text("Nyabugogo > Muhanga", style: TextStyle(color: Colors.white),),
      subtitle: const Text("Price: RWF 1,030", style: TextStyle(color: Colors.white),),
    ),

    const Icon(Icons.qr_code, size: 90, color: Colors.blue,),
    const SizedBox(height: 10,),

    ],)
  );
}