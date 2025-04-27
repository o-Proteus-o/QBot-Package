import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:q_chat_bot/widgets/chat_msg.dart';

void main() {
  testGoldens('ChatMsg golden test - user and bot messages',
      (WidgetTester tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'User Message',
        ChatMsg(
          msg: 'Hi, I am the user!',
          isUser: true,
          botMsgBgColor: Colors.grey,
          botIcon: const Icon(Icons.android),
          userMsgBgColor: Colors.blue,
          userIcon: const Icon(Icons.person),
        ),
      )
      ..addScenario(
        'Bot Message',
        ChatMsg(
          msg: 'Hello, I am the bot!',
          isUser: false,
          botMsgBgColor: Colors.grey,
          botIcon: const Icon(Icons.android),
          userMsgBgColor: Colors.blue,
          userIcon: const Icon(Icons.person),
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'chat_msg_widget');
  });
}
