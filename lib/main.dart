import 'package:flutter/material.dart';

//This is going to be an interactive storybook app with elements that keeps the user on their toes.
//Players will need to find the "correct" item amidst spooky Halloween-themed objects moving around the screen.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/halloween2.jpg"), // your custom image path
              fit: BoxFit.cover, // makes the image fill the entire screen
            ),
          ),
          child: Center(
            child: Text(
              'Welcome to the Haunted Story!',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                shadows: [
                  Shadow(blurRadius: 8, color: Colors.black, offset: Offset(2, 2))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

