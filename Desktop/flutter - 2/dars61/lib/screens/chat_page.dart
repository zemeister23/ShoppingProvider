import '../constants/import_packages.dart';

class ChatPage extends StatefulWidget {
  String? userEmail;
  ChatPage({Key? key, this.userEmail}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _messageController = TextEditingController();
  List listOfMessages = [];
  @override
  void initState() {
    super.initState();

    _getMessagesWithStream().listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _getMessagesWithStream();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _getMessagesWithStream(),
                builder: (context, AsyncSnapshot snap) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Text("${listOfMessages[index]['text']}",
                          textAlign: widget.userEmail ==
                                  listOfMessages[index]['sender']
                              ? TextAlign.right
                              : TextAlign.left);
                    },
                    itemCount: listOfMessages.length,
                  );
                },
              ),
              flex: 9,
            ),
            Expanded(
              child: TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type Message Here.....",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  _sendMessage() async {
    await _firestore.collection('messages').add(
      {
        'text': _messageController.text,
        'sender': widget.userEmail,
        'time': FieldValue.serverTimestamp()
      },
    );

    _messageController.clear();
    setState(() {});
  }

  _getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var item in messages.docs) {
      print(item.toString());
    }
  }

  Stream _getMessagesWithStream() async* {
    List a = [];
    await for (var message
        in _firestore.collection('messages').orderBy('time').snapshots()) {
      for (var messages in message.docs) {
        a.add(messages);
        yield message;
      }
      listOfMessages = a;
    }
  }
}
