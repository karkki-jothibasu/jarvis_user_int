import 'package:flutter/material.dart';
import 'package:jarvis/Chatscreen.dart';
import 'database.dart';

class savedpage extends StatefulWidget {
  @override
  State<savedpage> createState() => _savedpageState();
}

class Chats {
  final int id;
  final String title;
  final String question;
  final String answer;

  Chats({
    required this.id,
    required this.title,
    required this.question,
    required this.answer,
  });

  factory Chats.fromMap(Map<String, dynamic> map) {
    return Chats(
      id: map['id'],
      title: map['title'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}

class _savedpageState extends State<savedpage> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isRecording = false;
  String messages = "";
  List<Chats> _chats = [];
  List<Chats> _chatsall = [];
  bool _searching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadchats();
  }

  Future<void> _loadchats() async {
    final chatsMaps = await DatabaseHelper.getchats();
    final chats = chatsMaps.map((chatsMap) => Chats.fromMap(chatsMap)).toList();
    setState(() {
      _chats = chats;
      _chatsall = chats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
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
                  onPressed: () {},
                ),
                Spacer(),
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
              ],
            ),
            SizedBox(height: 0),
            Container(
              child: Text(
                '    Saved chats           ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 0),
            Container(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _searching = true;
                  });
                },
                child: SizedBox(
                  height: 40.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                _isRecording = !_isRecording;
                              });
                            },
                          ),
                        ]),
                        hintText: 'Search...',
                        hintStyle: TextStyle(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 6.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searching = value.isNotEmpty;
                          _chats = _searching
                              ? _chatsall
                                  .where((chats) => chats.title
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList()
                              : List.from(_chatsall);
                        });
                      },
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh your data here
          await _loadchats();
        },
        child: _chats.isNotEmpty
            ? ListView.builder(
                itemCount: _chats.length,
                itemBuilder: (context, index) {
                  final chats = _chats[index];
                  return Column(children: [
                    ListTile(
                      title: Text(
                        chats.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit,
                            size: 24,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.delete_forever,
                            size: 24,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm deletion',
                                  style: TextStyle(fontFamily: 'Jost')),
                              content: Text(
                                  'Are you sure you want to delete this chat?',
                                  style: TextStyle(fontFamily: 'Jost')),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('No',
                                      style: TextStyle(fontFamily: 'Jost')),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes',
                                      style: TextStyle(fontFamily: 'Jost')),
                                  onPressed: () async {
                                    await DatabaseHelper.deletechat(chats.id);
                                    setState(() {
                                      _chats.remove(chats);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ]);
                },
              )
            : Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'No chats are found',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
