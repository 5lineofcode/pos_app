import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class RejectButton extends StatefulWidget {
  final dynamic dataSource;
  final String refreshSource;
  final dynamic id;

  RejectButton({
    @required this.dataSource,
    @required this.refreshSource,
    @required this.id,
  });
  @override
  _RejectButtonState createState() => _RejectButtonState();
}

class _RejectButtonState extends State<RejectButton> {
  @override
  Widget build(BuildContext context) {
    return ExSmallButton(
      label: "Reject",
      onPressed: () async {
        var url =
            "${AppSession.baseUrl}${widget.dataSource}/reject/${widget.id}";
        await https.post(url);
        ExtremeRefresher.refresh(widget.refreshSource);
      },
      type: ButtonType.danger,
    );
  }
}
