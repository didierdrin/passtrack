// Promotions page
import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({super.key});

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: Colors.grey[200], // Simulate app bar background color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                      const Text("Filter"),
                    ],
                  ),
                ),
              ),
              // Top navigationBar items
              const SizedBox(
                height: 200,
              ),
              Icon(
                Icons.find_in_page,
                size: 60,
              ),
              Text("There are no promotions available"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.mic),
        label: const Text('Aid'),
      ),
    );
  }
}
