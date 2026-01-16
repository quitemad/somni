import 'package:flutter/material.dart';
import 'package:sleep_chart/sleep_chart.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late Map<SleepStage, Color> stageColors = {
    SleepStage.light: Theme.of(context).colorScheme.primary,
    SleepStage.deep: Theme.of(context).colorScheme.inversePrimary,
    SleepStage.rem: Theme.of(context).colorScheme.inverseSurface,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              image: AssetImage("assets/images/bg_plain.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          // 🔥 NEW LAYOUT: Everything in a Stack
          child: Stack(
            children: [



              // --------------------------------------------------
              // 3️⃣ FULL MOON ABOVE MOUNTAINS
              // --------------------------------------------------
              Positioned(
                left: 0,
                right: 0,
                top: 150,
                child: Hero(
                  tag: "fullMoon",
                  child: Image.asset(
                    "assets/svgs/full_moon.png",
                    height: 180,
                  ),
                ),
              ),
              // --------------------------------------------------
              // 2️⃣ MOUNTAINS ALWAYS AT BOTTOM (never shrink)
              // --------------------------------------------------
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Hero(
                  tag: "mountains",
                  child: Image.asset(
                    "assets/svgs/mountains.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // --------------------------------------------------
              // 1️⃣ FOREGROUND CONTENT (chart + spacing)
              // --------------------------------------------------
              Positioned(
                right: 10,
                left: 10,
                bottom: 50,
                child:
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                         style: BorderStyle.solid,
                        color:Colors.red,
                      )
                    ),
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Message",
                  suffixIcon: Icon(Icons.mic),
                  filled: true,
                    fillColor: Theme.of(context).colorScheme.primary.withAlpha(80),
                  ),

                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //
                //
                //   ],
                // ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
