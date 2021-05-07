/// The base class for implementing a parser
abstract class BaseMetadataParser {
  String? title;
  String? url;
  String? description;
  String? image;
  String? androidUrl;
  String? iosUrl;
  String? musicPreviewUrl;
  String? musicPreviewType;

  Metadata parse() {
    var m = Metadata();
    m.title = title;
    m.url = url;
    m.description = description;
    m.image = image;
    m.androidUrl = androidUrl ?? "";
    m.iosUrl = iosUrl ?? "";
    m.musicPreviewUrl = musicPreviewUrl ?? "";
    m.musicPreviewType = musicPreviewType;
    return m;
  }

  Map<String, String?> toMap() {
    return {
      'title': title,
      'url': url,
      'description': description,
      'image': image,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

/// Container class for Metadata
class Metadata extends BaseMetadataParser {}
