import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class TextAreaProvider {
  bool isFocused = false;
}

class ExTextAreaBackup extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final String value;
  final int maxLength;
  final int maxLines;
  final BuildContext context;
  final bool hideLabel;
  final bool enable;
  final double labelSize;
  final TextEditingController controller;

  final Function onFocus;
  final Function onLostFocus;

  final Function onSubmitted;

  ExTextAreaBackup({
    @required this.id,
    @required this.label,
    @required this.context,
    this.icon = Icons.note,
    this.value,
    this.controller,
    this.maxLength,
    this.maxLines = 4,
    this.enable = true,
    this.labelSize,
    this.hideLabel = false,
    this.onFocus,
    this.onLostFocus,
    this.onSubmitted,
  });

  @override
  _ExTextAreaBackupState createState() => _ExTextAreaBackupState();
}

class _ExTextAreaBackupState extends State<ExTextAreaBackup> {
  TextAreaProvider textAreaProvider = TextAreaProvider();
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) _controller = widget.controller;
    print("TextArea widget.controller = ${widget.controller.text}");

    if (widget.value == null) {
      Input.set(widget.id, "");
    } else {
      Input.set(widget.id, widget.value);
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (this.mounted) {
          if (widget.onFocus != null) {
            widget.onFocus();
          }
        }
      } else {
        if (this.mounted) {}
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getLabel() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
          top: 4.0,
          bottom: 4.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: Text(
          trans(widget.label),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: widget.labelSize ??
                Theme.of(context).textTheme.bodyText1.fontSize,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
          ),
        ),
      );
    }

    getTextField() {
      var primaryColor = Theme.of(context).primaryColor;

      return Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        padding: EdgeInsets.symmetric(vertical: 3.5),
        decoration: BoxDecoration(
          border: Border.all(
            color: textAreaProvider.isFocused ? primaryColor : Colors.grey[300],
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: -8,
              right: 0,
              bottom: 0,
              child: Container(
                child: ExTextFieldBase(
                  controller: _controller,
                  id: widget.id,
                  label: "",
                  icon: widget.icon,
                  useBorder: false,
                  useIcon: false,
                  enable: widget.enable,
                  value: widget.value != null ? widget.value : "",
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  keyboardType: TextInputType.multiline,
                  valueFromController: true,
                  textAreaProvider: textAreaProvider,
                  onContainerTap: () {
                    if (widget.enable == false) {
                      return;
                    }
                  },
                  onSubmitted: (text) {
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted();
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    }
                    focusNode.unfocus();
                  },
                  onFocus: () {
                    textAreaProvider.isFocused = true;
                    if (widget.onFocus != null) {
                      widget.onFocus();
                    }
                    setState(() {});
                  },
                  onLostFocus: () {
                    textAreaProvider.isFocused = false;
                    if (widget.onLostFocus != null) {
                      widget.onLostFocus();
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: <Widget>[
          if (!widget.hideLabel) getLabel(),
          getTextField(),
          Container(
            height: 6.0,
          ),
        ],
      ),
    );
  }
}
