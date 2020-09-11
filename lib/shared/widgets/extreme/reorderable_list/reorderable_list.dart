import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:pos_app/shared/widgets/extreme/reorderable_list/reorderable_item.dart';

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

  int _indexOfKey(String key) {
    return items.indexWhere((item) => item[widget.keyField] == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    var itemKey = item.toString().replaceAll("[<'", "").replaceAll("'>]", "");
    var newItemKey =
        newPosition.toString().replaceAll("[<'", "").replaceAll("'>]", "");

    int draggingIndex = _indexOfKey(itemKey);
    int newPositionIndex = _indexOfKey(newItemKey);

    if (draggingIndex == -1) {
      print("ZZZ");
      print("draggingIndex: $draggingIndex");
      print("item: $item");
      print("item: ${item.toString()}");
      print("itemKey: $itemKey");

      var filteredItem =
          items.indexWhere((item) => item[widget.keyField] == itemKey);

      print(filteredItem);

      return false;
    }
    final draggedItem = items[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      items.removeAt(draggingIndex);
      items.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    var itemKey = item.toString().replaceAll("[<'", "").replaceAll("'>]", "");
    final draggedItem = items[_indexOfKey(itemKey)];
    debugPrint("Reordering finished for ${draggedItem[widget.keyField]}}");
  }

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: this._reorderCallback,
      onReorderDone: this._reorderDone,
      child: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ReorderableListItem(
              data: items[index],
              isFirst: index == 0,
              isLast: index == items.length - 1,
              keyField: widget.keyField.toString(),
              itemBuilder: widget.itemBuilder,
            );
          },
        ),
      ),
    );
  }
}
