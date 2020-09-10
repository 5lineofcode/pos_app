import 'package:flutter/material.dart';

import 'package:pos_app/core.dart';

import 'ex_text_area_bk.dart';

class ExTextFieldBase extends StatefulWidget {
  final String id;
  final String label;
  final String hintText;
  final String helperText;
  final TextInputType keyboardType;
  final IconData icon;
  final String value;
  final TextAlign textAlign;
  final Color textColor;
  final Color prefixColor;
  final Color suffixColor;
  final TextEditingController controller;

  final EdgeInsets contentPadding;
  final double fontSize;

  final bool useBorder;
  final bool usePassword;
  final bool useIcon;
  final bool useSuffix;
  final bool useAutoFocus;
  final bool valueFromController;

  final bool enable;

  final int maxLines;
  final int maxLength;

  final TextAreaProvider textAreaProvider;

  final dynamic onChanged;
  final dynamic onFocus;
  final dynamic onLostFocus;
  final dynamic onSubmitted;
  final dynamic onContainerTap;

  ExTextFieldBase({
    @required this.id,
    this.label,
    this.hintText,
    this.helperText,
    this.value,
    this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.useBorder = false,
    this.usePassword = false,
    this.useIcon = false,
    this.useSuffix = true,
    this.useAutoFocus = false,
    this.valueFromController = false,
    this.textAlign = TextAlign.left,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.fontSize = 16.0,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.onFocus,
    this.onLostFocus,
    this.onSubmitted,
    this.onContainerTap,
    this.enable = true,
    this.textColor,
    this.prefixColor,
    this.suffixColor,
    this.textAreaProvider,
  });

  @override
  _ExTextFieldBaseState createState() => _ExTextFieldBaseState();
}

class _ExTextFieldBaseState extends State<ExTextFieldBase> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  bool showSuffix = false;

  void saveToHistory(id, value) {}

  @override
  void initState() {
    Input.set(widget.id, "");
    if (widget.value != null) {
      Input.set(widget.id, widget.value);
    }
    if (widget.controller != null) textEditingController = widget.controller;
    print(
        "TextArea Base textEditingController = ${textEditingController.text}");
    Input.textEditingController[widget.id] = textEditingController;
    textEditingController.text = widget.value;
    textEditingController.addListener(() {
      Input.set(widget.id, textEditingController.text);
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (this.mounted) {
          widget.textAreaProvider.isFocused = true;
          setState(() {
            showSuffix = true;
          });
          if (widget.onFocus != null) {
            widget.onFocus();
          }
        }
      } else {
        if (this.mounted) {
          widget.textAreaProvider.isFocused = false;
          setState(() {
            showSuffix = false;
          });

          if (widget.onLostFocus != null) {
            widget.onLostFocus();
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Input.get(widget.id) != null && widget.valueFromController == true) {
      var cursorPos = textEditingController.selection;

      textEditingController.text = Input.get(widget.id).toString() ?? '';

      if (cursorPos.start > textEditingController.text.length) {
        cursorPos = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length));
      }
      textEditingController.selection = cursorPos;
    }

    return InkWell(
      onTap: () {
        if (widget.enable == false) {
          widget.onContainerTap != null ? widget.onContainerTap() : Container();
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 3.5),
        child: TextField(
          autocorrect: false,
          keyboardType: widget.keyboardType,
          focusNode: focusNode,
          controller: textEditingController,
          obscureText: widget.usePassword,
          textAlign: widget.textAlign,
          autofocus: widget.useAutoFocus,
          enabled: widget.enable,
          onChanged: (text) {
            if (text.length == 1) {
              var newText = text[0].toUpperCase();

              textEditingController.value = TextEditingValue(
                text: newText,
                selection: TextSelection.collapsed(offset: 1),
              );
            }

            if (widget.onChanged != null) {
              widget.onChanged(text);
            }
          },
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
            fontFamily: Theme.of(context).textTheme.bodyText2.fontFamily,
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
          onSubmitted: (text) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted();
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
            focusNode.unfocus();
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          maxLines: widget.maxLines ?? 1,
          
          decoration: InputDecoration(
            prefixIcon: widget.useIcon == true
                ? Icon(
                    widget.icon,
                    color: widget.prefixColor ?? Theme.of(context).hintColor,
                  )
                : null,
            
            
            
            
            
            
            
            
            
            
            
            
            labelText: trans(widget.label),
            hintText: widget.hintText,
            helperText: widget.helperText,
            contentPadding: widget.contentPadding,
            isDense: true,
            border: !widget.useBorder
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
            focusedBorder: !widget.useBorder
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
          ),
        ),
      ),
    );
  }
}
