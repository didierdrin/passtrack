import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HelpbotController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxString chatHistory = RxString("");

  final TextEditingController textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _currentUser.value = _auth.currentUser;
    _currentUser.listen((user) async {
      if (user != null) {
        await loadChatHistory();
      }
    });
  }

  Future<void> loadChatHistory() async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final chatRef =
          _firestore.collection('users').doc(uid).collection('chatHistory');
      final chatSnapshot =
          await chatRef.orderBy('timestamp', descending: true).get();
      chatHistory.value = "";
      for (var doc in chatSnapshot.docs) {
        final data = doc.data();
        final message = "${data['role']}: ${data['message']}\n";
        chatHistory.value += message;
      }
    }
  }

  Future<String> _askQuestion(String question) async {
    // Replace "YOUR_API_KEY" with your actual Google Generative AI API key
    const String apiKey = "AIzaSyBbzbViHnvW4fJamrYr6FxWythUVXdSYMs";

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    // Save the question message first
    await saveMessage("You", question);

    // Use the question as the prompt for the model
    final content = [Content.text(question)];
    final response = await model.generateContent(content);

    // Check if the response is not null before saving it
    if (response.text != null) {
      await saveMessage("Mr.Volcano", response.text.toString());
    }

    return response.text ?? "Error: Response text was null";
  }

  Future<void> saveMessage(String role, String message) async {
    if (_currentUser.value != null) {
      final uid = _currentUser.value!.uid;
      final chatRef =
          _firestore.collection('users').doc(uid).collection('chatHistory');
      await chatRef.add({
        'role': role,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });


    }
  }

  void sendMessage() async {
    final String question = textController.text.trim();
    if (question.isNotEmpty) {
      chatHistory.value += "You: $question\n"; // Update chatHistory directly
      textController.clear();
      final String answer = await _askQuestion(question);
      chatHistory.value +=
          "Mr.Volcano: $answer\n"; // Update chatHistory directly
    }
  }
}
