import 'package:different_draggable_lists/category_repository.dart';
import 'package:flutter/cupertino.dart' hide ReorderableList;
import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter/rendering.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import 'category_reorderable_item.dart';

class FlutterReorderableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Reorderable List'),),
      body: StatefulFlutterReorderableList(),
    );
  }
}

class StatefulFlutterReorderableList extends StatefulWidget {
  // MyHomePage({Key? key, required this.title}) : super(key: key);
  @override
  _StatefulFlutterReorderableListState createState() => _StatefulFlutterReorderableListState();
}

class _StatefulFlutterReorderableListState extends State<StatefulFlutterReorderableList> {
  final List<ItemData> _items = [];

  _StatefulFlutterReorderableListState() {
    for (int i = 0; i < CategoryRepository().categories.length;  ++i) {
      _items.add(ItemData(
        CategoryRepository().categories[i].name,
        ValueKey(i),
      ));
    }
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    final draggedItem = _items[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      _items.removeAt(draggingIndex);
      _items.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = _items[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }

  // Returns index of item with given key
  int _indexOfKey(Key key) =>
      _items.indexWhere((ItemData d) => d.key == key);

  // Reordering works by having ReorderableList widget in hierarchy
  // containing ReorderableItems widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableList(
        onReorder: this._reorderCallback,
        onReorderDone: this._reorderDone,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CategoryReorderableItem(
                      data: _items[index],
                      // first and last attributes affect border drawn during dragging
                      isFirst: index == 0,
                      isLast: index == _items.length - 1,
                    );
                  },
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



