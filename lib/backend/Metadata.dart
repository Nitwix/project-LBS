import 'dart:convert' show json;
import 'dart:io' show File, FileSystemException;

enum MetadataField { version, labels, images, filename }

class Metadata {
  final String version;
  final List<String> labels;
  final List<ImageMetadata> images;

  Metadata(this.version, this.labels, this.images);

  // TODO maybe make this async...
  /// throws [FileSystemException]
  static Future<Metadata> fromFile(File file) async{
    String raw;
    try{
      raw = await file.readAsString();
    } on FileSystemException {
      // TODO
      rethrow;
    }
    final decoded = json.decode(raw);
    final String version = decoded["version"];
    final List<String> labels = decoded["labels"];
    final List<dynamic> rawImages = decoded["images"];

    if(version == null) throw InvalidMetadataException(MetadataField.version);
    if(labels == null) throw InvalidMetadataException(MetadataField.labels);
    if(rawImages == null) throw InvalidMetadataException(MetadataField.images);

    final List<ImageMetadata> images = rawImages.map(
        (metadata){
          final filename = metadata["filename"];
          final labels = metadata["labels"];
          if(filename == null) throw InvalidMetadataException(MetadataField.filename);
          if(labels == null) throw InvalidMetadataException(MetadataField.labels);

          return ImageMetadata(filename, labels);
        }
    ).toList();

    if(images == null) throw InvalidMetadataException(MetadataField.images);

    return Metadata(version, labels, images);
  }
}

class ImageMetadata {
  final String filename;
  final List<String> labels;

  ImageMetadata(this.filename, this.labels);
}

class InvalidMetadataException implements Exception {
  final MetadataField invalidField;
  InvalidMetadataException(this.invalidField);

  @override
  String toString() => "Didn't find metadata field $invalidField";
}