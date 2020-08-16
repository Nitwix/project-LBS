
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          )
        ],
      ),
    );
  }
}
