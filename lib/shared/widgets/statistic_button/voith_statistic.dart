import 'package:flutter/material.dart';

import 'package:pos_app/core.dart';

class VoithStatistic extends StatefulWidget {
  final IconData icon;
  final int count;
  final String label;
  final dynamic onTap;
  final bool visibleIf;
  final Color color;
  final Color textColor;

  VoithStatistic({
    @required this.icon,
    @required this.count,
    @required this.label,
    @required this.onTap,
    this.visibleIf,
    this.color,
    this.textColor,
  });

  @override
  _VoithStatisticState createState() => _VoithStatisticState();
}

class _VoithStatisticState extends State<VoithStatistic> {
  @override
  Widget build(BuildContext context) {
    if (widget.visibleIf == false) {
      return Container();
    }

    return Container(
      width: 260.0,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Card(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: widget.color ?? TS.getPrimaryColor(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        widget.icon,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${widget.count ?? 0}",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 24.0,
                                color: widget.textColor ?? Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              trans(widget.label),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: widget.textColor ?? Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(trans("Detail")),
                      Spacer(),
                      Icon(
                        FontAwesomeIcons.arrowCircleRight,
                        color: TS.getPrimaryColor(),
                        size: 18.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
