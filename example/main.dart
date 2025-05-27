import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:lottie/lottie.dart';
import 'package:q_chat_bot/q_bot.dart';
import 'package:q_chat_bot/q_bot_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final msgController = TextEditingController();
  late QBotConfig config;

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    config = QBotConfig(
      // Required arguments
      txtFieldPadding: EdgeInsets.fromLTRB(8, 8, 0, 8),
      msgController: msgController,
      hintText: 'Type / for suggestions.',
      welcomeMsg: 'Hi, I\'m Q-Bot. How can I assest you?',
      botIcon: Icon(Icons.android, color: Colors.white),
      botMsgBgColor: Colors.green,
      userIcon: Icon(Icons.person, color: Colors.white),
      userMsgBgColor: Colors.blue,
      paddingBetweenMsgs: 8.0,
      keywords: ['Hello', 'What are you', 'thanks'],
      responses: [
        'Hi, How can I help you?',
        'I\'m QBot, I\'m here to answer your questions about this app.',
        'You are welcome.',
      ],
      // Optional arguments
      bgColor: Colors.black87,
      txtFiledDecoration: InputDecoration(
        hintText: 'Type / for suggestions.',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      sendIcon: Icon(Icons.send_rounded, color: Colors.blue),
      msgStyle: TextStyle(color: Colors.white),
      divider: SizedBox(),
      // typing: SizedBox(
      //   height: 50,
      //   width: 50,
      //   child: Lottie.asset('assets/typing.json'),
      // ),
      delay: 2,
      // msgTime: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
      //   child: Text(
      //     DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      //     style: TextStyle(color: Colors.blueGrey),
      //   ),
      // ),
      txtFieldStyle: TextStyle(),
      txtFiledGgColor: Colors.white,
      txtFiledGgShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      suggestionsListBgColor: Colors.white,
      suggestionsListTextStyle: TextStyle(),
      suggestionsListHeight: 200,
      noResponseMsg: 'Sorry, I cannot find an answer.',
    );
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: QBot(config: config),
      ),
    );
  }
}
