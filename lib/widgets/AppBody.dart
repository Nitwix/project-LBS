import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io' show File;

import 'package:project_lbs/backend/Metadata.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO Unhandled Exception: Unable to load asset: assets/fruits/metadata.json ???
    var meta = Metadata.fromFutureString(DefaultAssetBundle.of(context).loadString("assets/fruits/metadata.json"));

    return Column(
      children: <Widget>[TargetsGrid(meta) , ImageToSort(meta)],
    );
  }
}

class TargetsGrid extends StatefulWidget {
  final Future<Metadata> metadata;
  TargetsGrid(this.metadata);

  @override
  _TargetsGridState createState() => _TargetsGridState(metadata);
}

class _TargetsGridState extends State<TargetsGrid> {
  static const _portraitCAC = 3;
  static const _landscapeCAC = 5;
  final Future<Metadata> metadata;

  _TargetsGridState(this.metadata);

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<Metadata>(
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.done:
              if(snapshot.hasData){
                final labels = snapshot.data.labels;
                return GridView.count(
                  crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait ? _portraitCAC : _landscapeCAC,
                  children: _makeTargets(labels),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                );
              }
              return Container();
            default:
              return Container();
          }
        },
        future: metadata,
      );
  }

  List<Widget> _makeTargets(List<LabelMetadata> labels) {
    return labels.map((l) {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Image.asset('assets/fruits/images/${l.representative}');
        },
      );
    }).toList();
  }
}

class ImageToSort extends StatefulWidget {
  final Future<Metadata> metadata;

  ImageToSort(this.metadata);

  @override
  _ImageToSortState createState() => _ImageToSortState(metadata);
}

extension RandomElement<T> on List<T> {
  T get randomElement{
    return this[Random().nextInt(this.length)];
  }
}

class _ImageToSortState extends State<ImageToSort> {
  final Future<Metadata> metadata;

  _ImageToSortState(this.metadata);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Metadata>(
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container();
          case ConnectionState.done:
            if(snapshot.hasData){
              final rndFilename = snapshot.data.images.randomElement.filename;
              final imgPath = "assets/fruits/images/$rndFilename";
              const imgSize = 200.0;
              final image = Image.asset(imgPath, fit: BoxFit.contain, height: imgSize, width: imgSize,);
              return Container(
                child: Center(
                  child: Draggable(
                    child: image,
                    feedback: image,
                  ),
                ),
              );
            }
            return Container();
          default:
            return Container();
        }
      },
      future: metadata,
    );
  }
}
