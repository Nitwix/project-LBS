
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatasetSelection extends StatelessWidget {
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
        title: const Text('Dataset selection'),
      ),
    );
  }
}
