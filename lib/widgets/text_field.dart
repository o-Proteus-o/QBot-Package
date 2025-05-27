import 'package:flutter/material.dart';

/// A custom text field widget for the chat interface.
///
/// This widget provides a text input field with an optional suggestions list
/// and allows users to type messages to the bot. The suggestions list is
/// shown when the user types a '/' character.
class MsgTextField extends StatefulWidget {
  /// Padding to be applied to the text field.
  final EdgeInsetsGeometry txtFieldPadding;

  /// The controller to manage the text input.
  final TextEditingController msgController;

  /// The TextStyle of the text field.
  final TextStyle? txtFieldStyle;

  /// Optional decoration for the text field.
  final InputDecoration? txtFiledDecoration;

  /// The hint text to show in the text field.
  final String hintTxt;

  /// List of keywords to trigger suggestions.
  final List<String> keywords;

  /// Height of the suggestions list.
  final double? suggestionsListHeight;

  /// Background color of the suggestions list.
  final Color? suggestionsListBgColor;

  /// Text Style of the suggestions list.
  final TextStyle? suggestionsListTextStyle;

  /// Constructs a [MsgTextField] widget.
  const MsgTextField({
    super.key,
    required this.txtFieldPadding,
    required this.msgController,
    this.txtFieldStyle,
    required this.hintTxt,
    this.txtFiledDecoration,
    required this.keywords,
    this.suggestionsListHeight,
    this.suggestionsListBgColor,
    this.suggestionsListTextStyle,
  });

  @override
  State<MsgTextField> createState() => _MsgTextFieldState();
}

class _MsgTextFieldState extends State<MsgTextField> {
  bool _showSuggestions = false;
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    widget.msgController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = widget.msgController.text;
    if (text.endsWith('/')) {
      setState(() {
        _showSuggestions = true;
        _suggestions = widget.keywords;
      });
    } else if (_showSuggestions) {
      setState(() {
        _showSuggestions = false;
      });
    }
  }

  @override
  void dispose() {
    widget.msgController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.txtFieldPadding,
      child: Column(
        children: [
          TextField(
            controller: widget.msgController,
            minLines: 1,
            maxLines: 4,
            scrollPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            style: widget.txtFieldStyle,
            decoration:
                widget.txtFiledDecoration ?? _defaultDecoration(widget.hintTxt),
          ),
          if (_showSuggestions)
            Container(
              height: widget.suggestionsListHeight ?? 150,
              color: widget.suggestionsListBgColor ?? Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return ListTile(
                    title: Text(
                      suggestion,
                      style: widget.suggestionsListTextStyle,
                    ),
                    onTap: () {
                      widget.msgController.text = suggestion;

                      widget.msgController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                          offset: widget.msgController.text.length,
                        ),
                      );
                      setState(() {
                        _showSuggestions = false;
                      });
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _defaultDecoration(hintTxt) {
    return InputDecoration(
      hintText: hintTxt,
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
