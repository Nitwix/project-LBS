import 'package:flutter/material.dart';

import 'package:project_lbs/backend/Metadata.dart';
import 'package:project_lbs/util/lists.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      return DragTarget<DragData>(
        builder: (context, candidateData, rejectedData) {
          return Image.asset('assets/fruits/images/${l.representative}');
        },
        onWillAccept: (dragData) => dragData.labels.contains(l),
        onAccept: (dragData) => print("accepted"),
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

class _ImageToSortState extends State<ImageToSort> {
  final Future<Metadata> _futureMetadata;
  Metadata _metadata;

  ImageMetadata _currentImage;

  _ImageToSortState(this._futureMetadata);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Metadata>(
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container();
          case ConnectionState.done:
            if(snapshot.hasData){
              _metadata ??= snapshot.data;
              _currentImage = snapshot.data.images.randomElement;
              final rndFilename = _currentImage.filename;
              final imgPath = "assets/fruits/images/$rndFilename";
              const imgSize = 200.0;
              final image = Image.asset(imgPath, fit: BoxFit.contain, height: imgSize, width: imgSize,);
              return Container(
                child: Center(
                  child: Draggable<DragData>(
                    child: image,
                    feedback: image,
                    data: DragData(_currentImage.labels),
                    onDragCompleted: (){
                      print("drag completed");
                      setState(() {
                        _currentImage = _metadata.images.randomElement;
                      });
                    },
                  ),
                ),
              );
            }
            return Container();
          default:
            return Container();
        }
      },
      future: _futureMetadata,
    );
  }
}

class DragData {
  final List<String> labels;

  DragData(this.labels);
}
