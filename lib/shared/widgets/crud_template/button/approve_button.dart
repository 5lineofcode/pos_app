import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ApproveButton extends StatefulWidget {
  final dynamic dataSource;
  final String refreshSource;
  final dynamic id;

  ApproveButton({
    @required this.dataSource,
    @required this.refreshSource,
    @required this.id,
  });
  @override
  _ApproveButtonState createState() => _ApproveButtonState();
}

class _ApproveButtonState extends State<ApproveButton> {
  @override
  Widget build(BuildContext context) {
    return ExSmallButton(
      label: "Approve",
      onPressed: () async {
        var url =
            "${AppSession.baseUrl}${widget.dataSource}/approve/${widget.id}";
        await https.post(url);
        ExtremeRefresher.refresh(widget.refreshSource);
      },
      type: ButtonType.success,
    );
  }
}
