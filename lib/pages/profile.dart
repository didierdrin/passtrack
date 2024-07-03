// Profile page
import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Your Account"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mcgpalette0[50],
                            fixedSize: const Size(240, 40),
                            ),
                          child: const Text("Sign In", style: TextStyle(color: Colors.white),)),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(text: "Don't have and account? "),
                            TextSpan(
                                text: "Create an Account",
                                style: TextStyle(color: Colors.green)),
                          ])),
                    ],
                  ),
                ),
              ),
            ),
            // Other profile properties
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Purchased tickets"),
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Language"),
                        trailing: const Text("English(US)"),
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Notifications"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Contact us"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Plan-To"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Country"),
                        trailing: const Text("Rwanda"),
                        onTap: () {},
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Log out"),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
