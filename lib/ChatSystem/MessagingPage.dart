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
            return ListTile(
              title: Text(messageProvider.messages[index]),
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
                Provider.of<MessageProvider>(context, listen: false)
                    .addMessage(message);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
