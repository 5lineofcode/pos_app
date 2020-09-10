import 'package:pos_app/core.dart';

class AppLoading {
  static ProgressDialog pr;

  static show(
    context, {
    String message,
  }) {
    pr = ProgressDialog(
      context,
      ProgressDialogType.Normal,
    );

    pr.setMessage(trans(message));

    pr.show();
  }

  static hide(context) {
    pr.hide(context);
  }
}
