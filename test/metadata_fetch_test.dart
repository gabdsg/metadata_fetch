import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  // TODO: Use a Mock Server for testing

  test('Metadata Parser', () async {
    var url = Uri.parse('https://flutter.dev');
    var response = await http.get(url);
    var document = responseToDocument(response);

    var data = MetadataParser.parse(document);
    print(data);

    // Just Opengraph
    var og = MetadataParser.OpenGraph(document);
    print(og);

    // Just Html
    var hm = MetadataParser.HtmlMeta(document);
    print(hm);

    // Just Json-ld schema
    var js = MetadataParser.JsonLdSchema(document);
    print(js);
  });
  group('Metadata parsers', () {
    test('JSONLD', () async {
      var url = Uri.parse('https://www.epicurious.com/');
      var response = await http.get(url);
      var document = responseToDocument(response);
      // print(response.statusCode);

      print(JsonLdParser(document));
    });

    test('JSONLD II', () async {
      var url = Uri.parse(
          'https://www.epicurious.com/expert-advice/best-soy-sauce-chefs-pick-article');
      var response = await http.get(url);
      var document = responseToDocument(response);
      // print(response.statusCode);

      print(JsonLdParser(document));
    });

    test('JSONLD III', () async {
      var url = Uri.parse(
          'https://medium.com/@quicky316/install-flutter-sdk-on-windows-without-android-studio-102fdf567ce4');
      var response = await http.get(url);
      var document = responseToDocument(response);
      // print(response.statusCode);

      print(JsonLdParser(document));
    });

    test('JSONLD IV', () async {
      var url = Uri.parse('https://www.distilled.net/');
      var response = await http.get(url);
      var document = responseToDocument(response);
      // print(response.statusCode);

      print(JsonLdParser(document));
    });
    test('HTML', () async {
      var url = Uri.parse('https://flutter.dev');
      var response = await http.get(url);
      var document = responseToDocument(response);
      print(response.statusCode);

      print(HtmlMetaParser(document).title);
      print(HtmlMetaParser(document).description);
      print(HtmlMetaParser(document).image);
    });

    test('OpenGraph Parser', () async {
      var url = Uri.parse('https://flutter.dev');
      var response = await http.get(url);
      var document = responseToDocument(response);
      print(response.statusCode);

      print(OpenGraphParser(document));
      print(OpenGraphParser(document).title);
      print(OpenGraphParser(document).description);
      print(OpenGraphParser(document).image);
    });

    test('Faulty', () async {
      var url = Uri.parse('https://google.ca');
      var response = await http.get(url);
      var document = responseToDocument(response);
      print(response.statusCode);

      print(OpenGraphParser(document).title);
      print(OpenGraphParser(document).description);
      print(OpenGraphParser(document).image);

      print(HtmlMetaParser(document).title);
      print(HtmlMetaParser(document).description);
      print(HtmlMetaParser(document).image);
    });
  });

  group('extract()', () {
    test('First Test', () async {
      var data = await extract('https://flutter.dev/');
      print(data);
      print(data?.description);
      expect(data?.toMap().isEmpty, false);
    });

    test('FB Test', () async {
      var data = await extract('https://facebook.com/');
      expect(data?.toMap().isEmpty, false);
    });

    test('Unicode Test', () async {
      var data = await extract('https://www.jpf.go.jp/');
      expect(data?.toMap().isEmpty, false);
    });

    test('Gooogle Test', () async {
      var data = await extract('https://google.ca');
      expect(data?.toMap().isEmpty, false);
      expect(data?.title, 'google');
    });

    test('Invalid Url Test', () async {
      var data = await extract('https://google');
      expect(data == null, true);
    });
  });
}
