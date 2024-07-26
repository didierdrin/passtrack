import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:passtrack/colors.dart';
import 'package:passtrack/components/helpbotcontroller.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final HelpbotController controller = Get.put(HelpbotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Help"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() => Text(controller.chatHistory.value)),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration:
                        const InputDecoration(hintText: "What's happening..."),
                  ),
                ),
                IconButton(
                    onPressed: controller.sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.black87,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
