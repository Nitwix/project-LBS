import 'dart:convert' show json;
import 'dart:io' show File, FileSystemException;

import 'package:flutter/cupertino.dart';

enum MetadataField { version, labels, images, filename, label, representative }

class Metadata {
  final String version;
  final List<LabelMetadata> labels;
  final List<ImageMetadata> images;

  Metadata(this.version, this.labels, this.images);

  static Metadata _from(String raw){
    final decoded = json.decode(raw);
    final String version = decoded["version"];
    final List<dynamic> rawLabels = decoded["labels"];
    final List<dynamic> rawImages = decoded["images"];

    if(version == null) throw InvalidMetadataException(MetadataField.version);
    if(rawImages == null) throw InvalidMetadataException(MetadataField.images);

    final List<LabelMetadata> labels = rawLabels
        .map((raw) => LabelMetadata.fromRaw(raw) as LabelMetadata).toList();
    if(labels == null) throw InvalidMetadataException(MetadataField.labels);

    final List<ImageMetadata> images = rawImages
        .map((raw) => ImageMetadata.fromRaw(raw) as ImageMetadata).toList();
    if(images == null) throw InvalidMetadataException(MetadataField.images);


    return Metadata(version, labels, images);
  }

  static Future<Metadata> fromFutureString(Future<String> rawFuture) async{
    String raw = await rawFuture;
    if(raw == null) throw FlutterError("Unable to load metadata");
    return _from(raw);
  }

  /// throws [FileSystemException]
  static Future<Metadata> fromFile(File file) async{
    String raw;
    try{
      raw = await file.readAsString();
    } on FileSystemException {
      // TODO
      rethrow;
    }
    return _from(raw);
  }
}

class LabelMetadata {
  final String label;
  /// Image that best represents the label
  final String representative;

  LabelMetadata(this.label, this.representative);

  static fromRaw(dynamic raw){
    final label = raw["label"];
    final repr = raw["representative"];
    if(label == null) throw InvalidMetadataException(MetadataField.label);
    if(repr == null) throw InvalidMetadataException(MetadataField.representative);

    return LabelMetadata(label, repr);
  }
}

class ImageMetadata {
  final String filename;
  final List<String> labels;

  ImageMetadata(this.filename, this.labels);

  static fromRaw(dynamic raw){
    final filename = raw["filename"];
    List<String> labels = List();
    for(var l in raw["labels"]){
      labels.add(l);
    }
    if(filename == null) throw InvalidMetadataException(MetadataField.filename);
    if(labels == null) throw InvalidMetadataException(MetadataField.labels);

    return ImageMetadata(filename, labels);
  }
}

class InvalidMetadataException implements Exception {
  final MetadataField invalidField;
  InvalidMetadataException(this.invalidField);

  @override
  String toString() => "Didn't find metadata field $invalidField";
}