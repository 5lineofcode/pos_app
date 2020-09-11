import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class ReorderableListItem extends StatelessWidget {
  ReorderableListItem({
    this.data,
    this.isFirst,
    this.isLast,
    this.keyField = "key",
  });

  final dynamic data;
  final bool isFirst;
  final bool isLast;
  final String keyField;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    Widget dragHandle = ReorderableListener(
      child: Container(
        padding: EdgeInsets.only(right: 18.0, left: 18.0),
        color: Color(0x08000000),
        child: Center(
          child: Icon(
            Icons.reorder,
            color: Color(0xFF888888),
          ),
        ),
      ),
    );

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  dragHandle,
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal: 14.0,
                      ),
                      child: Text(data["product_category_name"],
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: Key(data[keyField.toString()].toString()), //
      childBuilder: _buildChild,
    );
  }
}
