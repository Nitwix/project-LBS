// Learn By Sorting: Flutter app to help people learn by sorting.
// Copyright (C) 2020  Niels Lachat
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
// The license file can be found in the LICENSE file, at the root of the repo.
//
// The author can be contacted by email at nielsnfsmw@gmail.com.

import 'package:flutter/material.dart';

import 'package:project_lbs/backend/Metadata.dart';
import 'package:project_lbs/util/lists.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var meta = Metadata.fromFutureString(DefaultAssetBundle.of(context)
        .loadString("assets/fruits/metadata.json"));

    return Column(
      children: <Widget>[TargetsGrid(meta), ImageToSort(meta)],
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
  static const _portraitCAC = 3; // TODO : or 4 ? Needs to work on tablet & phone
  static const _landscapeCAC = 6;
  static const _cellsPadding = 30.0;

  final Future<Metadata> _futureMetadata;

  _TargetsGridState(this._futureMetadata);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Metadata>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final labels = snapshot.data.labels;
          return GridView.count(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? _portraitCAC
                    : _landscapeCAC,
            children: _makeTargets(labels, context),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          );
        } else {
          return Container();
        }
      },
      future: _futureMetadata,
    );
  }

  static List<Widget> _makeTargets(
      List<LabelMetadata> labels, BuildContext context) {
    return labels.map((l) {
      return Padding(
        padding: EdgeInsets.all(_cellsPadding),
        child: DragTarget<DragData>(
          builder: (context, candidateData, rejectedData) {
            return Image.asset('assets/fruits/images/${l.representative}');
          },
          onWillAccept: (dragData) {
            var c = dragData.labels.contains(l.label);
            return c;
          },
          onAccept: (dragData) => Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Correct!"),
            duration: Duration(milliseconds: 200),
          )),
        ),
      );
    }).toList();
  }
}

class ImageToSort extends StatefulWidget {
  final Future<Metadata> _futureMetadata;

  ImageToSort(this._futureMetadata);

  @override
  _ImageToSortState createState() => _ImageToSortState(_futureMetadata);
}

class _ImageToSortState extends State<ImageToSort> {
  static const _imgSize = 150.0;

  final Future<Metadata> _futureMetadata;
  Metadata _metadata;

  ImageMetadata _currentImage;

  _ImageToSortState(this._futureMetadata);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Metadata>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          _metadata ??= snapshot.data;
          _currentImage = snapshot.data.images.randomElement;
          final rndFilename = _currentImage.filename;
          final imgPath = "assets/fruits/images/$rndFilename";
          final image = Image.asset(
            imgPath,
            fit: BoxFit.contain,
            height: _imgSize,
            width: _imgSize,
          );
          return Center(
            child: Draggable<DragData>(
              child: image,
              feedback: image,
              data: DragData(_currentImage.labels),
              onDragCompleted: () {
                setState(() {
                  _currentImage = _metadata.images.randomElement;
                });
              },
            ),
          );
        } else {
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
