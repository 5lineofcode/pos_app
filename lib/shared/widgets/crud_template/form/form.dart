import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExForm extends StatefulWidget {
  final String dataSource;
  final List<Widget> children;

  ExForm({
    @required this.children,
    @required this.dataSource,
  });

  @override
  _ExFormState createState() => _ExFormState();
}

class _ExFormState extends State<ExForm> {
  @override
  void initState() {
    super.initState();
    InputCollector.reset();
    InputCollector.dataSource = widget.dataSource;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.children,
      ),
    );
  }
}
