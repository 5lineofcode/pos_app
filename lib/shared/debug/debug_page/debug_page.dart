import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return ExScaffold(
      title: "Debug Page",
      body: Column(
        children: [
          ExButton(
            label: "Call Native Code",
            onPressed: PlatformCode.callHelloFromNativeCode,
          ),
        ],
      ),
    );
  }
}
