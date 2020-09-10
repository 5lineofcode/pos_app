import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

import 'input_collector.dart';

class Input {
  static Map<String, dynamic> valueList = HashMap();
  static Map<String, TextEditingController> textEditingController = HashMap();
  static Map<String, ExDatePickerState> datePickerController = HashMap();
  static Map<String, ExTimePickerState> timePickerController = HashMap();
  static Map<String, ExComboState> comboController = HashMap();

  static get(String id) {
    return valueList[id];
  }

  static set(String id, dynamic value) {
    valueList[id] = value;
    InputCollector.add(id, value);
  }

  static setAndUpdate(String id, dynamic value) {
    textEditingController[id].text = value;
  }

  static setThousandSeparator(dynamic param) {
    double number = double.parse(param.toString());
    final formatter = NumberFormat("###,###.##", "id-ID");
    return formatter.format(number);
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  static getValueOnEdit(key, isEdit) {
    if (isEdit) {
      return Input.get(key).toString();
    } else {
      return null;
    }
  }
}
