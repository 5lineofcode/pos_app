import 'package:pos_app/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _dialogMessage = "Loading...";
enum ProgressDialogType { Normal, Download }

ProgressDialogType _progressDialogType = ProgressDialogType.Normal;
double _progress = 0.0;

bool _isShowing = false;

class ProgressDialog {
  _MyDialog _dialog;

  BuildContext _buildContext;

  ProgressDialog(
      BuildContext buildContext, ProgressDialogType progressDialogtype) {
    _buildContext = buildContext;

    _progressDialogType = progressDialogtype;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
  }

  void update({double progress, String message}) {
    if (_progressDialogType == ProgressDialogType.Download) {
      _progress = progress;
    }

    _dialogMessage = message;
    _dialog.update();
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide(context) {
    if (_isShowing) {
      _isShowing = false;

      if (context != null) {
        Navigator.of(context).pop();
      }
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = _MyDialog();
      _isShowing = true;

      showDialog<dynamic>(
        context: _buildContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              insetAnimationCurve: Curves.easeInOut,
              insetAnimationDuration: Duration(milliseconds: 100),
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: _dialog);
        },
      );
    }
  }
}

class _MyDialog extends StatefulWidget {
  final _dialog = _MyDialogState();

  update() {
    _dialog.changeState();
  }

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _MyDialogState extends State<_MyDialog> {
  var _showCancel = false;

  changeState() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    var cancelButton = FlatButton(
      child: Text(
        trans('Tutup'),
        style: TextStyle(color: Colors.white, fontSize: 11.0),
        overflow: TextOverflow.visible,
      ),
      color: Colors.grey[500],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      onPressed: () {
        _isShowing = false;
        Navigator.of(context).pop();
      },
    );

    var loadingBody = Row(
      children: <Widget>[
        const SizedBox(width: 15.0),
        SizedBox(
          width: 60.0,
          child: Image.asset(
            'assets/gif/loading.gif',
          ),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: _progressDialogType == ProgressDialogType.Normal
              ? Text(
                  _dialogMessage,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(_dialogMessage,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700)),
                      top: 35.0,
                    ),
                    Positioned(
                      child: Text("$_progress/100",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400)),
                      bottom: 15.0,
                      right: 15.0,
                    ),
                  ],
                ),
        )
      ],
    );

    Future.delayed(Duration(seconds: 7), () {
      if (this.mounted) {
        _showCancel = true;
        changeState();
      }
    });

    var sizedBox = SizedBox(
        width: 200,
        height: _showCancel ? 110.0 : 100.0,
        child: _showCancel
            ? Column(
                children: <Widget>[
                  loadingBody,
                  cancelButton,
                ],
              )
            : loadingBody);

    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: sizedBox,
    );
  }
}

class MessageBox {
  BuildContext buildContext;
  String message = " ", title = " ";

  MessageBox(this.buildContext, this.message, this.title);

  void show() {
    _showDialog();
  }

  void _showDialog() {
    showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('$title'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          content: SizedBox(
            height: 45.0,
            child: Center(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
