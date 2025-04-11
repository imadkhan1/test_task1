import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Square Mover',
      home: RedSquareMover(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RedSquareMover extends StatefulWidget {
  const RedSquareMover({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RedSquareMoverState createState() => _RedSquareMoverState();
}

class _RedSquareMoverState extends State<RedSquareMover> {
  Alignment _alignment = Alignment.center;
  bool _isMoving = false;

  void _moveLeft() async {
    setState(() => _isMoving = true);
    await _animateTo(Alignment.centerLeft);
    setState(() => _isMoving = false);
  }

  void _moveRight() async {
    setState(() => _isMoving = true);
    await _animateTo(Alignment.centerRight);
    setState(() => _isMoving = false);
  }

  Future<void> _animateTo(Alignment target) async {
    setState(() {
      _alignment = target;
    });
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final atLeft = _alignment == Alignment.centerLeft;
    final atRight = _alignment == Alignment.centerRight;

    return Scaffold(
      appBar: AppBar(title: Text('Red Square Mover'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: _alignment,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Container(width: 50, height: 50, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (_isMoving || atLeft) ? null : _moveLeft,
                  child: Text('To Left'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: (_isMoving || atRight) ? null : _moveRight,
                  child: Text('To Right'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
