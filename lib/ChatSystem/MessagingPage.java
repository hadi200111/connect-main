import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CampusConnect/ChatSystem/MessagesProvider.dart';

class MessagingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KeepConnect'),
      ),
      body: Column(
        children: [
          Expanded(child: MessageList()),
          MessageInput(),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, messageProvider, child) {
        return ListView.builder(
          reverse: true,
          itemCount: messageProvider.messages.length,
          itemBuilder: (context, index) {
            return Align(
              alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.blue.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  messageProvider.messages[index],
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send_outlined),
            onPressed: () {
              final message = _controller.text;
              if (message.isNotEmpty) {
                Provider.of<MessageProvider>(context, listen: false).addMessage(message);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
