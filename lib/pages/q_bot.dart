import 'package:flutter/material.dart';
import 'package:q_chat_bot/q_bot_config.dart';
import 'package:q_chat_bot/widgets/chat_msg.dart';
import 'package:q_chat_bot/widgets/text_field.dart';

class QBot extends StatefulWidget {
  final QBotConfig config;

  const QBot({super.key, required this.config});

  @override
  State<QBot> createState() => _QBotState();
}

class _QBotState extends State<QBot> {
  final List<ChatMsg> _messages = [];
  late final QBotConfig config;

  @override
  void initState() {
    super.initState();
    config = widget.config;
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
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, index) => _messages.reversed.toList()[index],
            ),
          ),
          config.divider ?? const Divider(height: 1.0),
          Card(
            margin: EdgeInsets.zero,
            elevation: 5,
            child: Row(
              children: [
                Expanded(
                  child: MsgTextField(
                    txtFieldPadding: config.txtFieldPadding,
                    msgController: config.msgController,
                    hintTxt: config.hintText,
                    txtFiledDecoration: config.txtFiledDecoration,
                    keywords: config.keywords,
                    suggestionsList: config.suggestionsList,
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
