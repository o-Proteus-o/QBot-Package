import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:q_chat_bot/widgets/chat_msg.dart';

void main() {
  testWidgets('displays user message correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatMsg(
            msg: 'Hello, I am user!',
            isUser: true,
            botMsgBgColor: Colors.grey,
            botIcon: const Icon(Icons.android),
            userMsgBgColor: Colors.blue,
            userIcon: const Icon(Icons.person),
          ),
        ),
      ),
    );

    expect(find.text('Hello, I am user!'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('displays bot message correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatMsg(
            msg: 'Hello, I am bot!',
            isUser: false,
            botMsgBgColor: Colors.grey,
            botIcon: const Icon(Icons.android),
            userMsgBgColor: Colors.blue,
            userIcon: const Icon(Icons.person),
          ),
        ),
      ),
    );

    expect(find.text('Hello, I am bot!'), findsOneWidget);
    expect(find.byIcon(Icons.android), findsOneWidget);
  });

  testWidgets('displays typing widget if provided',
      (WidgetTester tester) async {
    final typingWidget = const Text('Typing...');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatMsg(
            msg: 'Ignored message',
            isUser: false,
            botMsgBgColor: Colors.grey,
            botIcon: const Icon(Icons.android),
            userMsgBgColor: Colors.blue,
            userIcon: const Icon(Icons.person),
            isTyping: true,
            typing: typingWidget,
          ),
        ),
      ),
    );

    expect(find.text('Typing...'), findsOneWidget);
    expect(find.text('Ignored message'), findsNothing);
  });
}
