import 'package:flutter/material.dart';
import 'material_reorderable_list/base_example.dart';
import 'material_reorderable_list/material_reorderable_list.dart';

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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.amber,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialReorderableList(),),),
                  child: Text("Material reorderable list"),
                ),
                SizedBox(width: 5.0,),
                FlatButton(
                  color: Colors.amber,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaseExample(),),),
                  child: Text("Base example"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


