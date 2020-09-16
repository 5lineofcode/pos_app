import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ExReorderAbleList extends StatefulWidget {
  final List items;
  final String keyField;
  final dynamic itemBuilder;

  ExReorderAbleList({
    this.items,
    this.keyField = "key",
    this.itemBuilder,
  });

  @override
  _ExReorderAbleListState createState() => _ExReorderAbleListState();
}

class _ExReorderAbleListState extends State<ExReorderAbleList> {
  List items = [];

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = items.removeAt(oldIndex);
      items.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      padding: const EdgeInsets.all(8),
      needsLongPressDraggable: false,
      children: List.generate(items.length, (index) {
        var item = items[index];

        return widget.itemBuilder(item);
      }),
      onReorder: onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
    );
  }
}
