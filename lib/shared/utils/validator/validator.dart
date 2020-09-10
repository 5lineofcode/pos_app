import 'package:pos_app/core.dart';

class Validator {
  /*
  Example
  Validator.validate({
    "nama" : "required",
    "tanggal_awal" : "required",
    "tanggal_akhir" : "required",
    "memo" : "required"
  });
  */

  /*
  Validator.setCustomErrorMessage({
    "nama" : {
      "on_required": "This field is required",
      "on_max_length": "This field need more character",
    },
  });
  */

  static String getFieldName(String key) {
    var arr = key.split("_");
    for (var i = 0; i < arr.length; i++) {
      arr[i] = arr[i][0].toUpperCase() + arr[i].substring(1);
    }
    return arr.join(" ");
  }

  static bool isNotValid(context, obj) {
    List<String> errorMessages = [];
    Map<String, dynamic> userInputs = obj;

    userInputs.forEach((key, value) {
      var validatorString = value.toString().split("|").toList();
      var inputValue = Input.get(key);
      var fieldName = getFieldName(key);

      if (validatorString.where((item) => item == "required").isNotEmpty) {
        var message = "$fieldName Field is Required";

        if (inputValue == null || inputValue.toString().isEmpty) {
          errorMessages.add(message);
        }
      }
    });

    if (errorMessages.isEmpty) {
      return false;
    } else {
      ExAlert.showError(context: context, message: errorMessages[0]);
      return true;
    }
  }
}
