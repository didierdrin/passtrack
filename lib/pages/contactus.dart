import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class ContactusPage extends StatefulWidget {
  const ContactusPage({super.key});

  @override
  State<ContactusPage> createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Contact Us"),
      ),
      body: Column(
        children: [
          _contactTile(Icons.location_pin, "Address", "KK 6 Ave, Kigali, Rwanda"),
          _contactTile(Icons.email, "Email", "Volcanoexpressrw@gmail.com"),
          _contactTile(Icons.facebook, "Facebook", "https://www.facebook.com/volcanoltd"),
          _contactTile(Icons.phone, "Mobile Phone", "+250-788-351-253"),
        ],
      ),
    );
  }

  Widget _contactTile(iconValue, titleValue, subtitleValue) {
    return Card(
      elevation: 1,
      child: ListTile(onTap: () {},title: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(iconValue), 
            const SizedBox(width: 5,),
           Text(titleValue),
          ],), subtitle: Text(subtitleValue),),
        
    );
  }
}
