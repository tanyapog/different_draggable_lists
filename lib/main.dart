import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp (
      title: 'Different draggable lists',
      home: DifferentDraggableLists(),
    )
  );
}

class DifferentDraggableLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Different draggable lists'),
      ),
      body: Center(),
    );
  }
}


