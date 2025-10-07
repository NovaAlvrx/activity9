import 'package:flutter/material.dart';
import 'second_page.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

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
  final parser = EmojiParser();

  final List<String> emojiNames = [
    ':jack_o_lantern:',
    ':ghost:',
    ':spider:',
    ':skull:',
    ':candy:',
    ':brain:',
  ];

  final Random random = Random();

  late List<Offset> positions;

  Timer? timer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    positions = List.generate(emojiNames.length, (_) => randomOffset());
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        positions = List.generate(emojiNames.length, (_) => randomOffset());
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Offset randomOffset() {
    double x = 0.1 + random.nextDouble() * 0.8;
    double y = 0.1 + random.nextDouble() * 0.8;
    return Offset(x, y);
  }

  void onEmojiTap(String emojiName) {
    if (emojiName == ':brain:') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🧠 You found the brain! You win!')),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamed(context, '/second');
      });
    } else {
      // _audioPlayer.play(AssetSource('sounds/scream.mp3'));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('👻 Wrong emoji! Try again...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/halloween2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Click the Brain!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(0, 4),
                        ),
                        Shadow(
                          blurRadius: 12.0,
                          color: Colors.deepPurple.withOpacity(0.5),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ...List.generate(emojiNames.length, (index) {
                final emojiName = emojiNames[index];
                final emoji = parser.get(emojiName).code;
                final pos = positions[index];
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 800),
                  left: pos.dx * width - 24, // center emoji horizontally
                  top: pos.dy * height - 24, // center emoji vertically
                  child: GestureDetector(
                    onTap: () => onEmojiTap(emojiName),
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}