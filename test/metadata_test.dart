import 'dart:io';

import 'package:project_lbs/backend/Metadata.dart';

void main(){
  var meta = Metadata.fromFile(File("assets/fruits/metadata.json"));
  meta.then((value) => print(value.labels[2].representative));
}