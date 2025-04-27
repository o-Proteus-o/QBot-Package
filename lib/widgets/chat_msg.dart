import 'package:flutter/material.dart';

class ChatMsg extends StatelessWidget {
  final String msg;
  final bool isUser;

  final Color botMsgBgColor;
  final Icon botIcon;
  final Color userMsgBgColor;
  final Icon userIcon;
  final TextStyle? msgStyle;
  final Widget? msgTime;
  final bool? isTyping;
  final Widget? typing;

  const ChatMsg({
    super.key,
    required this.msg,
    required this.isUser,
    required this.botMsgBgColor,
    required this.botIcon,
    required this.userMsgBgColor,
    required this.userIcon,
    this.msgStyle,
    this.msgTime,
    this.isTyping,
    this.typing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: CircleAvatar(
                backgroundColor: botMsgBgColor,
                radius: 20.0,
                child: botIcon,
              ),
            ),
          typing ??
              Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: _msgDecoration(),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      msg,
                      style: msgStyle,
                    ),
                  ),
                  msgTime ??
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          '${DateTime.now().hour}:${DateTime.now().minute}',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                ],
              ),
          if (isUser)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: CircleAvatar(
                backgroundColor: userMsgBgColor,
                radius: 20.0,
                child: userIcon,
              ),
            ),
        ],
      ),
    );
  }

  Decoration _msgDecoration() {
    return BoxDecoration(
      color: isUser ? userMsgBgColor : botMsgBgColor,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(12.0),
        topRight: const Radius.circular(12.0),
        bottomLeft: isUser ? const Radius.circular(12.0) : Radius.zero,
        bottomRight: !isUser ? const Radius.circular(12.0) : Radius.zero,
      ),
    );
  }
}
