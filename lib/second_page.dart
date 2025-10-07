import 'package:flutter/material.dart';
import 'dart:async';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _counter = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_counter > 0 && _counter < 100) {
        setState(() {
          _counter -= 1;
        });
      } else if (_counter >= 100) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void incrementCounter(int amount) {
    if (_counter < 100) {
      setState(() {
        _counter += amount;
        if (_counter >= 100) {
          _counter = 100;
          _timer?.cancel();
        }
      });
    }
  }

  void decrementCounter(int amount) {
    if (_counter > 0) {
      setState(() {
        _counter -= amount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zombie Slider Game')),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/halloween3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _counter >= 100
                    ? 'RAHHH!!! Human elimated!!!'
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
                  fontSize: 24,
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double availableWidth = constraints.maxWidth;
                    const double emojiSize = 36;
                    final double maxLeft =
                        (availableWidth - emojiSize).clamp(0.0, availableWidth);
                    final double left = (_counter / 100) * maxLeft;

                    return SizedBox(
                      height: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: left,
                            top: 0,
                            child: const Text(
                              '🧟‍♂️',
                              style: TextStyle(fontSize: emojiSize),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: const Text(
                              '🧠',
                              style: TextStyle(fontSize: emojiSize),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Slider(
                              min: 0,
                              max: 100,
                              value: _counter.toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  _counter = value.toInt();
                                  if (_counter >= 100) _timer?.cancel();
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => incrementCounter(5),
                child: const Text('ATTACK'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => decrementCounter(5),
                child: const Text('RETREAT'),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }
}
