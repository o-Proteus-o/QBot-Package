import 'package:flutter/material.dart';

/// A widget that represents a chat message.
///
/// It can display either a user or bot message, and includes options for
/// custom styling of the message bubble and avatar, along with the message time.
class ChatMsg extends StatelessWidget {
  /// The message content.
  final String msg;

  /// Whether the message is from the user or the bot.
  final bool isUser;

  /// Background color for bot message bubbles.
  final Color botMsgBgColor;

  /// Icon for the bot's avatar.
  final Icon botIcon;

  /// Background color for user message bubbles.
  final Color userMsgBgColor;

  /// Icon for the user's avatar.
  final Icon userIcon;

  /// Optional text style for the message.
  final TextStyle? msgStyle;

  /// Optional widget displaying the time of the message.
  final Widget? msgTime;

  /// Flag indicating if the bot is typing.
  final bool? isTyping;

  /// Widget to show when the bot is typing.
  final Widget? typing;

  /// Constructs a [ChatMsg] widget.
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

  /// Returns a decoration for the message bubble.
  ///
  /// The decoration includes rounded corners for user and bot messages, with
  /// different background colors based on the sender.
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
