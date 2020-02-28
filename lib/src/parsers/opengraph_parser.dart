import 'package:html/dom.dart';
import 'package:metadata_fetch/src/utils/util.dart';

import 'base_parser.dart';

/// Takes a [http.Document] and parses [Metadata] from [<meta property='og:*'>] tags
class OpenGraphParser extends BaseMetadataParser {
  Document document;
  OpenGraphParser(this.document);

  /// Get [Metadata.title] from 'og:title'
  @override
  String get title => document?.head
      ?.querySelector("[property*='og:title']")
      ?.attributes
      ?.get('content');
  
  /// Get [Metadata.url] from 'og:url'
  @override
  String get url => document?.head
      ?.querySelector("[property*='og:url']")
      ?.attributes
      ?.get('content');

  /// Get [Metadata.description] from 'og:description'
  @override
  String get description => document?.head
      ?.querySelector("[property*='og:description']")
      ?.attributes
      ?.get('content');

  /// Get [Metadata.image] from 'og:image'
  @override
  String get image => document?.head
      ?.querySelector("[property*='og:image']")
      ?.attributes
      ?.get('content');
  
  
  String get androidUrl => document?.head?.querySelector("[property*='al:android:url']")?.attributes?.get('content');

  String get iosUrl => document?.head?.querySelector("[property*='al:ios:url']")?.attributes?.get('content');
  
  String get musicPreviewUrl => document?.head?.querySelector("[property*='music:preview_url:url']")?.attributes?.get('content');

  String get musicPreviewType => document?.head?.querySelector("[property*='music:preview_url:type']")?.attributes?.get('content');
}
