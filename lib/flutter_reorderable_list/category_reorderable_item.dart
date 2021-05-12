import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class CategoryReorderableItem extends StatelessWidget {
  final ItemData data;
  final bool isFirst;
  final bool isLast;

  CategoryReorderableItem({
    @required this.data,
    @required this.isFirst,
    @required this.isLast,
  });

  @override
  Widget build(BuildContext context) => ReorderableItem(
    key: data.key,
    childBuilder: (context, state) {
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

      return Container(
        decoration: decoration,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                        child: Text(data.title, style: Theme.of(context).textTheme.subtitle1),
                      )
                  ),
                  ReorderableListener(
                    child: Container(
                      padding: EdgeInsets.only(right: 18.0, left: 18.0),
                      color: Color(0x08000000),
                      child: Center(
                        child: Icon(Icons.reorder, color: Color(0xFF888888)),
                      ),
                    ),
                  ), // Triggers the reordering
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class ItemData {
  final String title;
  // Each item in reorderable list needs stable and unique key
  final Key key;
  ItemData(this.title, this.key);
}