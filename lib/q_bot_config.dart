import 'package:flutter/material.dart';

class QBotConfig {
  final Color? bgColor;
  final Widget? divider;
  final EdgeInsetsGeometry txtFieldPadding;
  final TextEditingController msgController;
  final InputDecoration? txtFiledDecoration;
  final String hintText;
  final Icon? sendIcon;
  //
  final String welcomeMsg;
  final String? noResponseMsg;
  final TextStyle? msgStyle;
  final Icon botIcon;
  final Color botMsgBgColor;
  final Icon userIcon;
  final Color userMsgBgColor;
  final double paddingBetweenMsgs;
  final Widget? msgTime;
  final Widget? typing;
  final Widget? suggestionsList;
  int delay;
  //
  final List<String> keywords;
  final List<String> responses;

  QBotConfig({
    this.bgColor,
    this.divider,
    required this.txtFieldPadding,
    required this.msgController,
    this.txtFiledDecoration,
    required this.hintText,
    this.sendIcon,
    //
    required this.welcomeMsg,
    this.noResponseMsg,
    this.msgStyle,
    required this.botIcon,
    required this.botMsgBgColor,
    required this.userIcon,
    required this.userMsgBgColor,
    required this.paddingBetweenMsgs,
    this.msgTime,
    this.typing,
    this.suggestionsList,
    this.delay = 3,
    //
    required this.keywords,
    required this.responses,
  });
}
