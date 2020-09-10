import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ButtonType {
  static Color primary = Colors.blue[900];
  static Color success = Colors.green;
  static Color danger = Colors.red[400];
  static Color warning = Colors.orange;
  static Color info = Colors.lightBlue;
  static Color disabled = Colors.grey[400];
  static Color textColor = Colors.white;
}

class ExButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final dynamic onPressed;
  final bool outlineButton;
  final bool enabled;

  final Color color;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;

  final Color type;

  final double radiusRounded;
  final double heigth;
  final double fontSize;
  final double iconSize;

  ExButton({
    @required this.label,
    @required this.onPressed,
    this.icon,
    this.type,
    this.heigth,
    this.outlineButton = false,
    this.enabled = true,
    this.color,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.radiusRounded = 4.0,
    this.fontSize = kIsWeb ? 12.0 : 14.0,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    getTextColor() {
      if (outlineButton) {
        if (textColor != null) {
          return textColor;
        } else {
          return Theme.of(context).textTheme.bodyText1.color;
        }
      } else {
        if (textColor != null) {
          return textColor;
        } else {
          return ButtonType.textColor;
        }
      }
    }

    if (!outlineButton) {
      getButtonColor() {
        if (!enabled) {
          return Colors.grey[400];
        }

        if (type == null) {
          return ButtonType.success;
        }

        return type;
      }

      return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: heigth ?? (kIsWeb ? 28.0 : null),
        child: FlatButton.icon(
          color: color ?? getButtonColor(),
          icon: icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: 14.0,
                )
              : Container(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusRounded),
          ),
          label: Text(
            label != null ? trans(label) : "",
            style: TextStyle(
              color: getTextColor(),
              fontSize: fontSize,
            ),
            overflow: TextOverflow.visible,
          ),
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: OutlineButton(
          borderSide: BorderSide(
            color: borderColor != null
                ? borderColor
                : Theme.of(context).textTheme.bodyText1.color,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusRounded),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize ?? 14.0,
                ),
              SizedBox(
                width: 6.0,
              ),
              Text(
                label != null ? trans(label) : "",
                style: TextStyle(
                  color: getTextColor(),
                  fontSize: fontSize,
                ),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          },
        ),
      );
    }
  }
}
