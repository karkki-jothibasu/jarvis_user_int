import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'database.dart';
import 'savedchat.dart';

class ChatScreen extends StatefulWidget {
  String chatMessages;

  ChatScreen({required this.chatMessages});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isRecording = false;
  List<String> messages1 = [];
  List<String> reply = [];
  FocusNode _focusNode = FocusNode();
  String responseText = "";

  Future<String> generateResponse() async {
    String apiKey = "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";
    String url = "https://api.openai.com/v1/chat/completions";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };
    String prompt =
        'Answer like jarvis, Question: "${_textEditingController.text}".';
    var body = json.encode({
      "model": 'gpt-3.5-turbo',
      "messages": [
        {"role": "user", "content": prompt}
      ],
      "temperature": 0.7,
      "max_tokens": 400
    });
    print("$prompt");
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response data: $data');
      var text = data['choices'][0]['message']['content'];
      var decodedText = utf8.decode(text.codeUnits);
      return decodedText.toString();
    } else {
      throw Exception(
          'We`re sorry for any trouble you may be experiencing and we`re doing our best to fix the issue as quickly as possible. In the meantime, keep an eye out for updates in the Play Store, where you can always find the latest version of our app. Thank you for your patience.');
    }
  }

  void submit() {
    generateResponse().then((response) {
      setState(() {
        responseText = response;
        reply.add(responseText);
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'We`re sorry for any trouble you may be experiencing and we`re doing our best to fix the issue as quickly as possible. In the meantime, keep an eye out for updates in the Play Store, where you can always find the latest version of our app. Thank you for your patience.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages1.add(widget.chatMessages);
    _textEditingController.text = widget.chatMessages;
    generateResponse().then((response) {
      setState(() {
        responseText = response;
        reply.add(responseText);
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'We`re sorry for any trouble you may be experiencing and we`re doing our best to fix the issue as quickly as possible. In the meantime, keep an eye out for updates in the Play Store, where you can always find the latest version of our app. Thank you for your patience.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });

    _textEditingController.clear();
  }

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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: "New Chat")),
                      (Route<dynamic> route) =>
                          false, // This will remove all the routes
                    );
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
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 540,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: messages1.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          messages1[index],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    // Reply
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '$responseText',
                                          style: TextStyle(fontSize: 14),
                                        ), /*
                                      child: Text(
                                        reply[index],
                                        style: TextStyle(fontSize: 14),
                                      ),*/
                                      ),
                                    ),
                                  ],
                                );
                              },
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
                                      focusNode: _focusNode,
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
                                              icon: Icon(Icons.send,
                                                  color: Colors.green),
                                              onPressed: () {
                                                _focusNode.unfocus();
                                                String message =
                                                    _textEditingController.text;
                                                submit();
                                                if (message.isNotEmpty) {
                                                  setState(() {
                                                    messages1.add(message);
                                                    _textEditingController
                                                        .clear();
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.save, color: Colors.green),
                                    onPressed: () async {
                                      String title = '';

                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Save this chat?',
                                                style: TextStyle(
                                                    fontFamily: 'Jost')),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  maxLength: 30,
                                                  onChanged: (value) {
                                                    title = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter a title',
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'Jost'),
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily: 'Jost',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel',
                                                    style: TextStyle(
                                                        fontFamily: 'Jost')),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  final String question =
                                                      '${messages1[0]}';
                                                  final String answer =
                                                      '${reply[0]}';

                                                  await DatabaseHelper
                                                      .insertchats(
                                                          title: title,
                                                          question: question,
                                                          answer: answer);

                                                  Navigator.pop(context);
                                                },
                                                child: Text('Save',
                                                    style: TextStyle(
                                                        fontFamily: 'Jost')),
                                              ),
                                            ],
                                          );
                                        },
                                      );
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
          ],
        ));
  }
}
