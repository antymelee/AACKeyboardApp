// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const AACKeyboardApp());
}

class AACKeyboardApp extends StatelessWidget {
  const AACKeyboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const AACKeyboardHomePage(),
    );
  }
}

class AACKeyboardHomePage extends StatefulWidget {
  const AACKeyboardHomePage({super.key});

  @override
  _AACKeyboardHomePageState createState() => _AACKeyboardHomePageState();
}

class _AACKeyboardHomePageState extends State<AACKeyboardHomePage> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  final List<String> _keys = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
    'Space'
  ];

  // Speak the typed text
  Future<void> _speak() async {
    if (_controller.text.isNotEmpty) {
      await _flutterTts.speak(_controller.text);
    }
  }

  // Handle key press
  void _onKeyPressed(String key) {
    setState(() {
      if (key == 'Space') {
        _controller.text += ' ';
      } else {
        _controller.text += key;
      }
    });
  }

  // Clear text
  void _clearText() {
    setState(() {
      _controller.clear();
    });
  }

  // Backspace functionality
  void _backspace() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AAC Keyboard App"),
      ),
      body: Column(
        children: [
          // Top Section: Expanding text area, Speak, Backspace, Clear
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _speak,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _controller.text,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _speak,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "Speak",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _backspace,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text(
                          "←",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _clearText,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text(
                          "Clear",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section: Custom Keyboard
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10, // Number of keys per row
                childAspectRatio: 1.5,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: _keys.length,
              itemBuilder: (context, index) {
                final key = _keys[index];
                return ElevatedButton(
                  onPressed: () => _onKeyPressed(key),
                  child: Text(
                    key == 'Space' ? 'Space' : key,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
