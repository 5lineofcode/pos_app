import 'dart:async';

import 'package:flutter/material.dart';

class ExOverlaySupport extends StatefulWidget {
  final Widget child;

  ExOverlaySupport({
    this.child,
  });

  @override
  ExOverlaySupportState createState() => ExOverlaySupportState();
}

class ExOverlaySupportState extends State<ExOverlaySupport> {
  bool visible = false;

  show() {
    if (this.mounted) setState(() => visible = true);
  }

  hide() {
    if (this.mounted) setState(() => visible = false);
  }

  static ExOverlaySupportState instance;
  @override
  void initState() {
    super.initState();
    instance = this;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: widget.child,
          ),
          if (visible) _OverlayWidget.overlayWidget
        ],
      ),
    );
  }
}

class _OverlayWidget {
  static Widget overlayWidget = Container();
}

class OverlayHelper {
  static OverlayResult overlayResult = OverlayResult.NONE;

  static Future show(Widget widget) async {
    _OverlayWidget.overlayWidget = widget;
    ExOverlaySupportState.instance.show();

    await checkOverlayStatus();
    return overlayResult;
  }

  static hide() {
    ExOverlaySupportState.instance.hide();
  }

  static Future checkOverlayStatus() async {
    bool done = false;

    while (done == false) {
      await Future.delayed(Duration(milliseconds: 100), () {
        if (ExOverlaySupportState.instance.visible == false) {
          done = true;
        }
      });
    }
  }
}

enum OverlayResult {
  NONE,
  QUIT,
  RETRY,
  YES,
  NO,
  CANCEL,
  ERROR,
}
