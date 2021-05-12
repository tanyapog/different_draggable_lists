import 'package:different_draggable_lists/category_repository.dart';
import 'package:different_draggable_lists/model/category.dart';
import 'package:flutter/material.dart';

// This class is appropriate for views with a small number of children
// because constructing the List requires doing work for every child
// that could possibly be displayed in the list view
// instead of just those children that are actually visible.
//
// All list items must have a key.
// https://api.flutter.dev/flutter/material/ReorderableListView-class.html
class MaterialReorderableList extends StatelessWidget {
  //const MaterialReorderableList({Key key}) : super(key: key);

  static const String _title = 'Material ReorderableList';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title),),
        body: StatefulMaterialReorderableList(),
      ),
    );
  }
}

class StatefulMaterialReorderableList extends StatefulWidget {
  //const MyReorderableList({Key key}) : super(key: key);

  @override
  _StatefulMaterialReorderableListState createState() => _StatefulMaterialReorderableListState();
}

class _StatefulMaterialReorderableListState extends State<StatefulMaterialReorderableList> {

  final List<Category> _categories = CategoryRepository().categories;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    print('categories: $_categories');

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: <Widget> [
        for (int i = 0; i < _categories.length; i++)
          ListTile(
            key: Key('$i'),
            tileColor: _categories[i].position.isOdd ? oddItemColor : evenItemColor,
            title: Text(_categories[i].name),
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Category category = _categories.removeAt(oldIndex);
          _categories.insert(newIndex, category);
        });
      },
    );
  }
}