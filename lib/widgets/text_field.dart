import 'package:flutter/material.dart';

class MsgTextField extends StatefulWidget {
  final EdgeInsetsGeometry txtFieldPadding;
  final TextEditingController msgController;
  final InputDecoration? txtFiledDecoration;
  final String hintTxt;
  final List<String> keywords;
  final Widget? suggestionsList;
  const MsgTextField({
    super.key,
    required this.txtFieldPadding,
    required this.msgController,
    required this.hintTxt,
    this.txtFiledDecoration,
    required this.keywords,
    this.suggestionsList,
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
            decoration:
                widget.txtFiledDecoration ?? _defaultDecoration(widget.hintTxt),
          ),
          if (_showSuggestions)
            widget.suggestionsList ??
                Container(
                  height: 150,
                  color: Colors.white,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        title: Text(suggestion),
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
