import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zombie Slider Game')),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/halloween2.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _counter >= 100
                    ? 'RAHHH! Human eliminated!'
                    : _counter < 20
                        ? 'The hunt begins...'
                        : _counter < 40
                            ? 'Brains... need brains...'
                            : _counter < 60
                                ? 'Don\'t let the human escape!'
                                : _counter < 80
                                    ? 'Almost got them!'
                                    : _counter < 90
                                        ? 'I taste victory...'
                                        : 'The human is mine!!!',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              Slider(
                min: 0,
                max: 100,
                value: _counter.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _counter = value.toInt();
                  });
                },
                activeColor: Colors.red,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_counter < 100) _counter += 1;
                  });
                },
                child: const Text('ATTACK'),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_counter > 0) _counter -= 1;
                  });
                },
                child: const Text('RETREAT'),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Main Page'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}