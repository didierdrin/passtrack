import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passtrack/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imgSample = "assets/images/imgSample.png";
  String sampleText =
      "The increase in fuel for vehicles has caused many to worry about the increased bus tickets across the country.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text(
                  "Timeline",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                height: 370,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.landscape,
                        color: mcgpalette0[50],
                      ),
                      title: const Text("Volcano Express"),
                      subtitle: const Text("1hr ago"),
                    ),
                    SizedBox(
                      // height: 150,
                      child: FadeInImage(
                        placeholder: AssetImage(imgSample),
                        image: const NetworkImage(
                            "https://res.cloudinary.com/dezvucnpl/image/upload/v1718987020/x3q1pmbzjrpvgekfvsuj.jpg"),
                      ),
                    ),
                    SizedBox(
                      child: Text(sampleText),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
