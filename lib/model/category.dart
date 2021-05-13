import 'package:flutter/material.dart';

class Category {
  String name;
  int position;

  Category({
    @required this.name,
    @required this.position
  });

  factory Category.empty() => Category(name: '', position: null);

  @override
  String toString() {
    return "${this.position}-${this.name}";
  }
}