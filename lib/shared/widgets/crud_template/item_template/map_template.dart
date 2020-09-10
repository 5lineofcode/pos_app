import 'package:flutter/material.dart';

class ItemMapTemplate extends StatefulWidget {
  @override
  _ItemMapTemplateState createState() => _ItemMapTemplateState();
}

class _ItemMapTemplateState extends State<ItemMapTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Colors.red,
      child: Row(
        children: <Widget>[
          Container(
            width: 200.0,
            color: Colors.red,
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
