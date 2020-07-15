import 'package:flutter/material.dart';

const _labels = ["apple", "avocado", "pear"];

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Column(
      children: <Widget>[TargetsGrid() , ImageToSort()],
    );
  }
}

class TargetsGrid extends StatefulWidget {
  @override
  _TargetsGridState createState() => _TargetsGridState();
}

class _TargetsGridState extends State<TargetsGrid> {
  static const _portraitCAC = 3;
  static const _landscapeCAC = 5;

  @override
  Widget build(BuildContext context) {
      return GridView.count(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? _portraitCAC : _landscapeCAC,
        children: _makeTargets(),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      );
  }

  List<Widget> _makeTargets() {
    return _labels.map((s) {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Image.asset('assets/test_images/$s/0.jpg');
        },
      );
    }).toList();
  }
}

class ImageToSort extends StatefulWidget {
  @override
  _ImageToSortState createState() => _ImageToSortState();
}

class _ImageToSortState extends State<ImageToSort> {
  @override
  Widget build(BuildContext context) {
    const imgName = "assets/test_images/apple/0.jpg";
    const imgSize = 200.0;
    final image = Image.asset(imgName, fit: BoxFit.contain, height: imgSize, width: imgSize,);
    return Container(
      child: Center(
        child: Draggable(
          child: image,
          feedback: image,
        ),
      ),
    );
  }
}
