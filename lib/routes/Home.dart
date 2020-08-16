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