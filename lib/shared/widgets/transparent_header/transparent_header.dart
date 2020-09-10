import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class TransparentHeader extends StatefulWidget {
  final String label;
  final String backgroundAssetUrl;
  final dynamic onHistoryClick;

  TransparentHeader({
    @required this.label,
    @required this.backgroundAssetUrl,
    @required this.onHistoryClick,
  });

  @override
  _TransparentHeaderState createState() => _TransparentHeaderState();
}

class _TransparentHeaderState extends State<TransparentHeader> {
  getHeaderContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1.5,
          ),
          onPressed: () {},
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.onHistoryClick();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.backgroundAssetUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.7,
            child: Container(
              height: 70.0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: getHeaderContent(),
          ),
        ],
      ),
    );
  }
}
