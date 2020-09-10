import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ExAlert {
  static bool disabled = false;
  static String successImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static String infoImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static String errorImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static String warningImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static String confirmationImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static String approveImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static String rejectImage =
      "https://image.slidesharecdn.com/proposalkerjasamaseminargaji-190816231219/95/forum-sdm-bali-proposal-kerjasama-smk-kampus-seminar-gajiid-1-638.jpg";

  static double buttonFontSize = 16.0;

  static getAlertStyle(context) {
    if (ExAlert.disabled) return;
    return AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black54,
      titleStyle: TextStyle(
        color: Colors.red,
        fontSize: 16.0,
      ),
      descStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 14.0,
      ),
      constraints: !kIsWeb
          ? null
          : BoxConstraints(
              maxWidth: 400.0,
            ),
    );
  }

  static getImage(src) {
    if (src.indexOf("http") > -1) {
      return Image.network(src);
    } else {
      return Image.asset(
        src,
      );
    }
  }

  static showInfo({
    @required BuildContext context,
    String title = "",
    String message = "",
    dynamic onOk,
    dynamic onCancel,
  }) {
    if (ExAlert.disabled) return;
    Alert(
      context: context,
      title: trans("Info"),
      desc: trans(message),
      image: getImage(successImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: ButtonType.info,
          child: Text(
            trans("Ok"),
            style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        )
      ],
    ).show();
    return;
  }

  static showError({
    @required BuildContext context,
    String title = "",
    String message = "",
    dynamic onOk,
    dynamic onCancel,
  }) async {
    if (ExAlert.disabled) return;
    await Alert(
      context: context,
      title: trans("Ada Kesalahan"),
      desc: trans(message),
      image: getImage(errorImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: ButtonType.danger,
          child: Text(
            trans("Ok"),
            style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        )
      ],
    ).show();
  }

  static showWarning({
    @required BuildContext context,
    String title = "",
    String message = "",
    dynamic onOk,
    dynamic onCancel,
  }) {
    if (ExAlert.disabled) return;
    Alert(
      context: context,
      title: trans("Peringatan"),
      desc: trans(message),
      image: getImage(warningImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: ButtonType.warning,
          child: Text(
            trans("Ok"),
            style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        )
      ],
    ).show();
  }

  static showConfirmation({
    @required BuildContext context,
    String title = "",
    String message = "",
    dynamic onOk,
    dynamic onCancel,
  }) {
    if (ExAlert.disabled) return;
    Alert(
      context: context,
      title: trans("Konfirmasi"),
      desc: trans(message),
      image: getImage(confirmationImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: Colors.grey[400],
          child: Text(
            trans("Tidak"),
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: buttonFontSize,
            ),
          ),
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
        DialogButton(
          color: ButtonType.danger,
          child: Text(
            trans("Ya"),
            style: TextStyle(
              color: Colors.white,
              fontSize: buttonFontSize,
            ),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
      ],
    ).show();
  }

  static Future showApproveConfirmation({
    @required BuildContext context,
    String title = "",
    String message = "",
    Image alertImage,
    dynamic onOk,
    dynamic onCancel,
    String okText,
    String cancelText,
  }) async {
    if (ExAlert.disabled) return;
    return await Alert(
      context: context,
      title: trans(title ?? "Konfirmasi"),
      desc: trans(message),
      image: alertImage ?? getImage(approveImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: Colors.grey[400],
          child: Text(
            trans(cancelText ?? "Tidak"),
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: buttonFontSize,
            ),
          ),
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
        DialogButton(
          color: ButtonType.danger,
          child: Text(
            trans(okText ?? "Ya"),
            style: TextStyle(
              color: Colors.white,
              fontSize: buttonFontSize,
            ),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
      ],
    ).show();
  }

  static showRejectConfirmation({
    @required BuildContext context,
    String title = "",
    String message = "",
    dynamic onOk,
    dynamic onCancel,
  }) {
    if (ExAlert.disabled) return;
    Alert(
      context: context,
      title: trans("Konfirmasi Reject"),
      desc: trans(message),
      image: getImage(rejectImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: Colors.grey[400],
          child: Text(
            trans("Tidak"),
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: buttonFontSize,
            ),
          ),
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
        DialogButton(
          color: ButtonType.danger,
          child: Text(
            trans("Ya"),
            style: TextStyle(
              color: Colors.white,
              fontSize: buttonFontSize,
            ),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
      ],
    ).show();
  }

  static showSuccess({
    @required BuildContext context,
    String title = "",
    String message = "",
    dynamic onOk,
    dynamic onCancel,
  }) {
    if (ExAlert.disabled) return;
    Alert(
      context: context,
      title: trans("Berhasil"),
      desc: trans(message),
      image: getImage(successImage),
      style: getAlertStyle(context),
      buttons: [
        DialogButton(
          color: ButtonType.success,
          child: Text(
            trans("Ok"),
            style: TextStyle(color: Colors.white, fontSize: buttonFontSize),
          ),
          onPressed: () {
            if (onOk != null) {
              onOk();
            } else {
              Navigator.pop(context);
            }
          },
          width: 120,
        )
      ],
    ).show();
  }

  static showContentInAlert({
    @required BuildContext context,
    Widget content,
  }) {
    if (ExAlert.disabled) return;
    var alert = SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                constraints: BoxConstraints(
                  maxWidth: 400.0,
                ),
                color: kIsWeb ? Colors.transparent : Colors.black26,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      child: InkWell(
                        onTap: () {},
                        child: content,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return alert;
        });
    return;
  }
}
