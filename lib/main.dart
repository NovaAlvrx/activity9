import 'package:flutter/material.dart';
import 'second_page.dart';

// Interactive storybook app: find the "correct" item amidst spooky Halloween-themed objects.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haunted Story',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Haunted Story'),
      routes: {
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/halloween2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Welcome to the Haunted Story!',
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
              shadows: [
                Shadow(blurRadius: 8, color: Colors.black, offset: Offset(2, 2))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}