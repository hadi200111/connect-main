import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CampusConnect/ChatSystem/MessagesProvider.dart';
import 'package:CampusConnect/ChatSystem/MessagingPage.dart';

void main() {
    runApp(MessagesPage());
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MessagingPage(),
      ),
    );
  }
}