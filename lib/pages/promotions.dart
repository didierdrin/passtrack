import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Promotion {
  final String id;
  final String title;
  final String subtitle;
  final Timestamp timestamp;

  Promotion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });

  factory Promotion.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Promotion(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({super.key});

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  bool choice = false;
  bool choice2 = false;
  final logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

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
                padding: const EdgeInsets.all(8.0),
                child: _buildSearchBar(),
              ), 
              _buildPromotionList(),
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

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search promotions...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
    );
  }

  Widget _buildPromotionList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('promotions').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Promotion> promotions = snapshot.data!.docs
            .map((doc) => Promotion.fromFirestore(doc))
            .where((promotion) =>
                promotion.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                promotion.subtitle.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        if (promotions.isEmpty) {
          return const Text("There are no promotions available");
        }

        return Column(
          children: promotions.map((promotion) => _promotionTile(promotion)).toList(),
        );
      },
    );
  }

  Widget _promotionTile(Promotion promotion) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.find_in_page, size: 40),
        title: Text(promotion.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(promotion.subtitle),
            Text(DateFormat('dd-MM-yyyy').format(promotion.timestamp.toDate())),
          ],
        ),
        onTap: () => _showPromotionDetails(promotion),
      ),
    );
  }

  void _showPromotionDetails(Promotion promotion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Promotion Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${promotion.title}'),
              Text('Subtitle: ${promotion.subtitle}'),
              Text('Date: ${DateFormat('dd-MM-yyyy').format(promotion.timestamp.toDate())}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}