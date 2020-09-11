import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pos_app/core.dart';

class ExComboPopup extends StatefulWidget {
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
  final Color backgroundColor;
  final TextEditingController controller;

  final double labelFontSize;
  final double valueFontSize;

  final EdgeInsets contentPadding;
  final EdgeInsetsGeometry padding;
  final double fontSize;

  final bool useBorder;
  final bool usePassword;
  final bool useIcon;
  final bool useSuffix;
  final bool useAutoFocus;
  final bool valueFromController;
  final bool enableAutoUppercase;
  final bool hideLabel;

  final bool enable;

  final int maxLines;
  final int maxLength;

  final Function(String) onChanged;
  final Function() onFocus;
  final Function(String) onSubmitted;
  final Function() onTap;

  final List items;
  final String labelField;
  final String valueField;

  ExComboPopup({
    @required this.id,
    this.label,
    this.hintText,
    this.helperText,
    this.value = "-- Select --",
    this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.useBorder = false,
    this.usePassword = false,
    this.useIcon = false,
    this.useSuffix = false,
    this.useAutoFocus = false,
    this.valueFromController = false,
    this.textAlign = TextAlign.left,
    this.padding,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
    this.fontSize,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.onFocus,
    this.onSubmitted,
    this.onTap,
    this.enable = true,
    this.textColor = Colors.grey,
    this.prefixColor,
    this.suffixColor,
    this.backgroundColor,
    this.labelFontSize,
    this.valueFontSize,
    this.enableAutoUppercase = false,
    this.hideLabel = false,
    this.items,
    this.labelField = "label",
    this.valueField = "value",
  });

  @override
  _ExComboPopupState createState() => _ExComboPopupState();
}

class _ExComboPopupState extends State<ExComboPopup> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List items = [];
  bool showSuffix = false;

  void saveToHistory(id, value) {}

  @override
  void initState() {
    items = widget.items;
    Input.set(widget.id, "");
    if (widget.value != null) {
      Input.set(widget.id, widget.value);
    }
    if (widget.controller != null) textEditingController = widget.controller;
    Input.textEditingController[widget.id] = textEditingController;
    textEditingController.text = widget.value;
    textEditingController.addListener(() {
      /*
      ! Temporary Fix
      Focus akan menjadi kacau ketika memilih combo
      Saat ini, combo belum memiliki event onFocus,
      Sehingga focus tidak bisa di blur dari combo langsung.
      Sedangkan Combo yang dibungkus InkWell pun tidak bekerja.
      */

      Input.set(widget.id, textEditingController.text);
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (this.mounted) {
          setState(() {
            showSuffix = true;
          });
          if (widget.onFocus != null) {
            widget.onFocus();
          }
        }
      } else {
        if (this.mounted) {
          setState(() {
            showSuffix = false;
          });
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

    getLabel() {
      return Container(
        padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
        width: MediaQuery.of(context).size.width,
        child: Text(
          trans(widget.label),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: widget.labelFontSize ??
                Theme.of(context).textTheme.bodyText1.fontSize,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
          ),
        ),
      );
    }

    getTextField() {
      // var primaryColor = Theme.of(context).primaryColor;

      return InkWell(
        onTap: () async {
          if (widget.enable == false) {
            return;
            // widget.onTap != null ? widget.onTap() : Container();
          }
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                contentPadding: EdgeInsets.all(8.0),
                content: Container(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Add New ${widget.label}",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: ButtonType.warning,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: ButtonType.warning,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        height: 0.8,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: List.generate(
                            items.length,
                            (index) {
                              var item = items[index];
                              return InkWell(
                                onTap: () {
                                  var value = item[widget.valueField];
                                  var label = item[widget.labelField];

                                  Input.set(widget.id, value);
                                  textEditingController.text = label;
                                  Get.back();
                                },
                                child: Container(
                                  width: Get.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 4.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          item[widget.labelField],
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.edit,
                                          size: 18.0,
                                          color: Colors.grey[800],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        height: 0.8,
                        color: Colors.grey[300],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          FlatButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: ButtonType.warning,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 38.0,
          padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
          decoration: BoxDecoration(
            color: widget.enable == false ? Colors.grey[200] : null,
            border: Border.all(
              color: focusNode.hasFocus ? Colors.orange : Colors.grey[300],
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  autocorrect: false,
                  keyboardType: widget.keyboardType,
                  focusNode: focusNode,
                  controller: textEditingController,
                  obscureText: widget.usePassword,
                  textAlign: widget.textAlign,
                  autofocus: widget.useAutoFocus,
                  enabled: false,
                  onChanged: (text) {
                    if (text.length == 1 &&
                        widget.enableAutoUppercase == true) {
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
                  onSubmitted: (text) {
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted(text);
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    }
                    focusNode.unfocus();
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.maxLength),
                  ],
                  maxLines: widget.maxLines ?? 1,
                  style: TextStyle(
                    fontSize: widget.valueFontSize ??
                        Theme.of(context).textTheme.bodyText2.fontSize,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2.fontFamily,
                    color: widget.textColor ??
                        Theme.of(context).textTheme.bodyText2.color,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: widget.useIcon == true
                        ? Icon(
                            widget.icon,
                            color: widget.prefixColor ??
                                Theme.of(context).hintColor,
                          )
                        : null,
                    hintText: widget.hintText,
                    helperText: widget.helperText,
                    contentPadding: widget.contentPadding,
                    isDense: true,
                    border: !widget.useBorder
                        ? InputBorder.none
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                    // focusedBorder: !widget.useBorder
                    //     ? InputBorder.none
                    //     : OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //           color: Colors.orange,
                    //           width: 2.0,
                    //         ),
                    //         borderRadius: BorderRadius.circular(5.0),
                    //       ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 3.5),
      child: Column(
        children: <Widget>[
          if (!widget.hideLabel) getLabel(),
          Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    getTextField(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
