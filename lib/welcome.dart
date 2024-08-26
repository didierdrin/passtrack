import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/control.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  double _swipeProgress = 0.0;

  Future<void> _onSwipeRight() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstLaunch', false);

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ControlPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Book",
                            style: TextStyle(
                                fontSize: 30,
                                color: mcgpalette0[50],
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "Now",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold)),
                      ]),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          "https://res.cloudinary.com/dezvucnpl/image/upload/v1723359955/welcome_zeihyg.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    const Padding(padding: EdgeInsets.all(5), child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Text("Quick & Easy\nto Travel anywhere\n&Anytime.", style: TextStyle(fontSize: 16),),
                      ],
                    ),),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
      
                  color: mcgpalette0[50]!,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
                  child: SwipeTrack(
                    onSwipeComplete: _onSwipeRight,
                    onSwipeUpdate: (progress) {
                      setState(() {
                        _swipeProgress = progress;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SwipeTrack extends StatefulWidget {
  final VoidCallback onSwipeComplete;
  final Function(double) onSwipeUpdate;

  const SwipeTrack(
      {super.key, required this.onSwipeComplete, required this.onSwipeUpdate});

  @override
  SwipeTrackState createState() => SwipeTrackState();
}

class SwipeTrackState extends State<SwipeTrack> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _progress += details.delta.dx / context.size!.width;
          _progress = _progress.clamp(0.0, 1.0);
          widget.onSwipeUpdate(_progress);
        });
      },
      onHorizontalDragEnd: (details) {
        if (_progress > 0.5) {
          setState(() {
            _progress = 1.0;
          });
          widget.onSwipeComplete();
        } else {
          setState(() {
            _progress = 0.0;
          });
        }
        widget.onSwipeUpdate(_progress);
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 300 * _progress,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: mcgpalette0[50],
              ),
            ),
            Center(
              child: Text(
                'Swipe to start',
                style: TextStyle(
                  color: _progress > 0.5 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.chevron_right,
                  color: _progress > 0.5 ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
