import 'package:flutter/material.dart';
import 'package:q_chat_bot/q_bot_config.dart';
import 'package:q_chat_bot/widgets/chat_msg.dart';
import 'package:q_chat_bot/widgets/text_field.dart';

/// The main widget for the QBot chat interface.
///
/// This widget sets up the chat bot with a configurable interface, where
/// users can interact with the bot and receive responses.
class QBot extends StatefulWidget {
  /// Configuration options for the QBot.
  final QBotConfig config;

  /// Creates a [QBot] instance with the provided [config].
  const QBot({super.key, required this.config});

  @override
  State<QBot> createState() => _QBotState();
}

class _QBotState extends State<QBot> {
  /// List of chat messages in the conversation.
  final List<ChatMsg> _messages = [];

  /// Holds the bot's configuration settings.
  late final QBotConfig config;

  @override
  void initState() {
    super.initState();
    config = widget.config;

    // Add a welcome message from the bot.
    _messages.add(ChatMsg(
      msg: config.welcomeMsg,
      isUser: false,
      botMsgBgColor: config.botMsgBgColor,
      botIcon: config.botIcon,
      userMsgBgColor: config.userMsgBgColor,
      userIcon: config.userIcon,
      msgStyle: config.msgStyle,
      msgTime: config.msgTime,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.bgColor,
      body: Column(
        children: [
          // Display the list of chat messages.
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, index) => _messages.reversed.toList()[index],
            ),
          ),
          config.divider ?? const Divider(height: 1.0),
          // Text field and send button.
          Card(
            margin: EdgeInsets.zero,
            elevation: 5,
            color: config.txtFiledGgColor,
            shape: config.txtFiledGgShape,
            child: Row(
              children: [
                Expanded(
                  child: MsgTextField(
                    txtFieldPadding: config.txtFieldPadding,
                    msgController: config.msgController,
                    txtFieldStyle: config.txtFieldStyle,
                    hintTxt: config.hintText,
                    txtFiledDecoration: config.txtFiledDecoration,
                    keywords: config.keywords,
                    suggestionsListHeight: config.suggestionsListHeight,
                    suggestionsListBgColor: config.suggestionsListBgColor,
                    suggestionsListTextStyle: config.suggestionsListTextStyle,
                  ),
                ),
                IconButton(
                  onPressed: sendMsg,
                  icon: config.sendIcon ?? const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Sends a message to the chat, both from the user and the bot.
  void sendMsg() {
    final msg = config.msgController.text.trim();
    if (msg.isEmpty) return;

    setState(() {
      _messages.add(ChatMsg(
        msg: msg,
        isUser: true,
        botMsgBgColor: config.botMsgBgColor,
        botIcon: config.botIcon,
        userMsgBgColor: config.userMsgBgColor,
        userIcon: config.userIcon,
        msgStyle: config.msgStyle,
        msgTime: config.msgTime,
      ));

      // Find a matching response from the bot.
      final response = _findResponse();

      _messages.add(ChatMsg(
        msg: 'typing...',
        isUser: false,
        botMsgBgColor: config.botMsgBgColor,
        botIcon: config.botIcon,
        userMsgBgColor: config.userMsgBgColor,
        userIcon: config.userIcon,
        msgStyle: config.msgStyle,
        msgTime: config.msgTime,
        isTyping: true,
        typing: config.typing,
      ));

      Future.delayed(Duration(seconds: config.delay), () {
        _messages.removeLast();

        setState(() {
          _messages.add(ChatMsg(
            msg: response,
            isUser: false,
            botMsgBgColor: config.botMsgBgColor,
            botIcon: config.botIcon,
            userMsgBgColor: config.userMsgBgColor,
            userIcon: config.userIcon,
            msgStyle: config.msgStyle,
            msgTime: config.msgTime,
          ));
        });
      });
    });

    config.msgController.clear();
  }

  /// Finds a suitable response for the user's message.
  ///
  /// This checks if the user's message contains any keywords, and returns
  /// the corresponding response. If no match is found, a default message is returned.
  String _findResponse() {
    for (int i = 0; i < config.keywords.length; i++) {
      if (config.msgController.text
          .trim()
          .toLowerCase()
          .contains(config.keywords[i].toLowerCase())) {
        return config.responses[i];
      }
    }
    return config.noResponseMsg ??
        "Sorry, I can't find an answer for your question.";
  }
}
