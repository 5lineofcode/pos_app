import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class StatisticButton extends StatefulWidget {
  final String text;
  final String information;
  final dynamic onTap;

  final dynamic gradient;
  final dynamic color;

  final dynamic textColor;
  final dynamic informationColor;

  final bool enableLiveDot;

  StatisticButton({
    @required this.text,
    @required this.information,
    @required this.onTap,
    this.gradient,
    this.color,
    this.textColor = Colors.white,
    this.informationColor = Colors.white,
    this.enableLiveDot = false,
  });

  @override
  _StatisticButtonState createState() => _StatisticButtonState();
}

class _StatisticButtonState extends State<StatisticButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: AppSessionTheme.boxShadow,
          gradient: widget.gradient,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    trans(widget.information),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: widget.informationColor,
                      fontSize: TS.config["menu_font_size"],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.enableLiveDot && int.tryParse(widget.text) > 0)
              Positioned(
                top: 10,
                right: 10,
                child: AnimatedDot(),
              )
          ],
        ),
      ),
    );
  }
}
