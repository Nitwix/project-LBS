import 'package:flutter/material.dart';
import 'package:project_lbs/widgets/AppBody.dart';

class Home extends StatelessWidget {
  final String _appName;
  Home(this._appName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Select dataset'),
              onTap: () {
                Navigator.pushNamed(context, '/dataset_selection');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(_appName),
      ),
      body: AppBody(),
    );
  }
}