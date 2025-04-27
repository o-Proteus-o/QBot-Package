import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:q_chat_bot/widgets/text_field.dart';

void main() {
  testWidgets('shows suggestions when "/" is typed',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    final keywords = ['keyword1', 'keyword2'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MsgTextField(
            txtFieldPadding: EdgeInsets.all(8),
            msgController: controller,
            hintTxt: 'Type a message...',
            keywords: keywords,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '/');
    await tester.pump();

    expect(find.text('keyword1'), findsOneWidget);
    expect(find.text('keyword2'), findsOneWidget);
  });

  testWidgets('fills text field when suggestion is tapped',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    final keywords = ['suggestion1'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MsgTextField(
            txtFieldPadding: EdgeInsets.all(8),
            msgController: controller,
            hintTxt: 'Type a message...',
            keywords: keywords,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '/');
    await tester.pump();

    await tester.tap(find.text('suggestion1'));
    await tester.pump();

    expect(controller.text, 'suggestion1');
  });
}
