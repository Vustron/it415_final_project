import 'package:flutter/material.dart';

class MessageDetailScreen extends StatefulWidget {
  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/placeholder_logo.png'),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Kriss Benwat',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                            color: Color.fromARGB(255, 1, 234, 24),
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Replace with your chat messages widget if needed
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // Placeholder for the chat messages
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: const Text('Chat messages go here'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Write message...',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton.small(
                      onPressed: () {},
                      backgroundColor: Colors.lightBlue,
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
