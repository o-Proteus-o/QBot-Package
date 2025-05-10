import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:q_chat_bot/q_bot.dart';
import 'package:q_chat_bot/q_bot_config.dart';

void main() {
  testWidgets('Send a message and receive bot response',
      (WidgetTester tester) async {
    final config = QBotConfig(
      welcomeMsg: 'Welcome!',
      keywords: ['hi', 'hello'],
      responses: ['Hi there!', 'Hello!'],
      msgController: TextEditingController(),
      txtFieldPadding: EdgeInsets.fromLTRB(8, 8, 0, 8),
      hintText: '',
      botIcon: Icon(Icons.android, color: Colors.white),
      botMsgBgColor: Colors.green,
      userIcon: Icon(Icons.person, color: Colors.white),
      userMsgBgColor: Colors.blue,
      paddingBetweenMsgs: 8.0,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: QBot(config: config),
      ),
    );

    expect(find.text('Welcome!'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.tap(find.byIcon(Icons.send_rounded));

    await tester.pump(Duration(seconds: config.delay));

    expect(find.text('hi'), findsOneWidget);

    expect(find.text('Hi there!'), findsOneWidget);
  });
}
