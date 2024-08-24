// Profile page
import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/pages/contactus.dart';
import 'package:passtrack/pages/sign.dart';
import 'package:flutter/gestures.dart';
import  'package:passtrack/pages/planto.dart'; 


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _fullName;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }



   Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('userinfo')
          .doc('default_doc_id')
          .get();

      setState(() {
        _fullName = doc['full name'];
        _email = doc['email'];
      });
    }
  }

  Future<void> _showAddDetailsDialog() async {
  String? fullName = _fullName;
  String? email = _email;

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const  Text('Add User Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              onChanged: (value) => fullName = value,
              controller: TextEditingController(text: fullName),
            ),
            const SizedBox(height: 16), // Add some space between fields
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
              controller: TextEditingController(text: email),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () async {
            User? user = _auth.currentUser;
            if (user != null) {
              await _firestore
                  .collection('users')
                  .doc(user.uid)
                  .collection('userinfo')
                  .doc('default_doc_id')
                  .set({
                'full name': fullName,
                'email': email,
              });
              Navigator.of(context).pop();
              _loadUserData();
            }
          },
        ),
      ],
    ),
  );
}
  
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Your Account"),
                      ),
                      const SizedBox(height: 10),
                      if (user != null) ...[
                        Text('Full Name: ${_fullName ?? 'Not set'}'),
                        Text('Email: ${_email ?? 'Not set'}'),
                        ElevatedButton(
                          onPressed: _showAddDetailsDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mcgpalette0[50],
                            fixedSize: const Size(240, 40),
                          ),
                          child: const Text(
                            "Update Details",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignInUp()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mcgpalette0[50],
                            fixedSize: const Size(240, 40),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: "Create an Account",
                                style: const TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const SignInUp()),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactusPage()));
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                      ListTile(
                        title: const Text("Plan-To"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlanToPage())); 
                        },
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
