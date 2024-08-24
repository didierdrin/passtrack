import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class Post {
  final String title;
  final String subtitle;
  final String imgUrl;
  final String description;

  Post(
      {required this.title,
      required this.subtitle,
      required this.imgUrl,
      required this.description});

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Post(
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      imgUrl: data['imgUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }
}

class PostProvider with ChangeNotifier {
  final logger = Logger(); 
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .get();
      _posts =
          querySnapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      logger.d('Error fetching posts: $e');
    }
  }
}
