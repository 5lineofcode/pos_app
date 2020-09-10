import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class SaveButton extends StatefulWidget {
  final String dataSource;
  final String refreshSource;
  SaveButton({
    @required this.dataSource,
    @required this.refreshSource,
  });
  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool loading = false;

  doSubmit() async {
    setState(() {
      loading = true;
    });

    print(InputCollector.valueList);
    await DynamicSubmitter.create(
      InputCollector.dataSource,
      InputCollector.valueList,
    );

    setState(() {
      loading = false;
    });

    ExtremeRefresher.refresh(widget.refreshSource);
  }

  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: loading ? "Loading..." : "Save",
      type: loading ? ButtonType.disabled : ButtonType.success,
      icon: Icons.save,
      onPressed: () => doSubmit(),
    );
  }
}
