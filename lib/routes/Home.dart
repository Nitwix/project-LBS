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
              title: const Text('Browse datasets'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/browse_datasets');
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: const Text('Import dataset'),
            ),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: const Text('Statistics'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
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