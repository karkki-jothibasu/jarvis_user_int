import 'package:flutter/material.dart';
import 'package:jarvis/Chatscreen.dart';
import 'savedchat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jarvis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  TextEditingController _textEditingController = TextEditingController();
  bool _isRecording = false;
  String messages = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => savedpage()),
                    );
                  },
                ),
                Image.asset(
                  'assets/jarvis.png',
                  width: 28,
                  height: 28,
                ),
                SizedBox(width: 8),
                Text(
                  'Jarvis',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.volume_up_sharp,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.document_scanner,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.replay_circle_filled_rounded,
                    color: Color.fromARGB(255, 43, 232, 245),
                    size: 30,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 0),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  // Handle New chat button press
                },
                child: Text(
                  '     NEW CHAT                 ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 43, 232, 245)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 540,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.question_mark, size: 13),
                              radius: 8,
                            ),
                          ),
                          SizedBox(height: 0),
                          Flexible(
                            child: Text(
                              'Not sure of what to ask?',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 0),
                          FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Check out our preset prompts for inspiration! ',
                                          ),
                                          TextSpan(
                                            text: 'Let`s go ->',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Icon(Icons.sunny, size: 13),
                          SizedBox(height: 6),
                          Flexible(
                            child: Text(
                              'Examples',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 5),
                          FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Explain quantum computing in simple terms.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Icon(
                                    Icons.send,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Writing letter to my boss asking for raise.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Icon(
                                    Icons.send,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Write me a shopping list for eating healthy.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Icon(
                                    Icons.send,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        hintText: 'Type here...',
                                        hintStyle: TextStyle(fontSize: 13),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.mic,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _isRecording = !_isRecording;
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                String messages =
                                                    _textEditingController.text;

                                                setState(() {
                                                  _textEditingController
                                                      .clear();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                                chatMessages:
                                                                    messages)),
                                                  );
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.save,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      // Handle save button press
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
