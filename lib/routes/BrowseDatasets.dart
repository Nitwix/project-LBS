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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_lbs/backend/Metadata.dart';

class BrowseDatasets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Browse Datasets'),
      ),
      body: _BrowseDatasetsBody(),
    );
  }
}

class _BrowseDatasetsBody extends StatefulWidget {
  final Future<List<Metadata>> _fDatasetsMeta;

  _BrowseDatasetsBody(): _fDatasetsMeta = _retreiveDatasetsMeta();

  static Future<List<Metadata>> _retreiveDatasetsMeta() async{
    List<Metadata> meta = List<Metadata>();

    // retreive default datasets from assets dir
    final Directory default_datasets = Directory('assets/default_datasets');
    final List<FileSystemEntity> datasets = await default_datasets.list().toList();

    print(datasets);
    // TODO : COMPLETE

    return null;
  }

  @override
  __BrowseDatasetsBodyState createState() => __BrowseDatasetsBodyState();
}

class __BrowseDatasetsBodyState extends State<_BrowseDatasetsBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search)
            ),
          ),
          _makeDatasetsList()
        ],
      ),
    );
  }

  Widget _makeDatasetsList(){
    return Container(); // TODO
  }
}
