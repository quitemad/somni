import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_fog_plain.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentGeometry.bottomCenter,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Hero(tag: "fullMoon", child:Image.asset("assets/svgs/mini_moon.png")),

                  ),
                  Hero(tag:"mountains",child: Image.asset("assets/svgs/mountains.png")),
                ],
              ),
            ),

            // const Text('You have pushed the button this many times:'),
          ],
        ),
      ),
    );
  }
}
