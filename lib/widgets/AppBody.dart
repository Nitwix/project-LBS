import 'dart:io';

import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[SortingClassesGrid() /*, ImageToSort()*/],
    );
  }
}

class SortingClassesGrid extends StatefulWidget {
  @override
  _SortingClassesGridState createState() => _SortingClassesGridState();
}

class _SortingClassesGridState extends State<SortingClassesGrid> {
  static const _portraitCAC = 3;
  static const _landscapeCAC = 5;

  static const _classes = ["apple", "avocado", "pear"];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.count(
        crossAxisCount:
            orientation == Orientation.portrait ? _portraitCAC : _landscapeCAC,
        children: _makeSortingClasses(),
      );
    });
  }

  List<Widget> _makeSortingClasses() {
    return _classes.map((s) {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Image.file(
            File('assets/$s/0.jpg'),
            scale: 1,
            repeat: ImageRepeat.noRepeat,
          );
        },
      );
    }).toList();
  }
}
