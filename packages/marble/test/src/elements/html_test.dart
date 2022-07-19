import 'package:marble/marble.dart';
import 'package:test/test.dart';

void main() {
  group('Html', () {
    test('render an empty tag', () {
      final html = Html();
      expect(html.render(), '<html/>');
    });

    test('render its children', () {
      final html = Html(
        children: [
          Html(),
        ],
      );
      expect(html.render(), '<html><html/></html>');
    });

    test('render its attributes', () {
      final html = Html(
          id: 'my-element',
          className: 'my-class',
      );
      expect(html.render(), '<html id="my-element" class="my-class"/>');
    });

    test('render a text', () {
      final html = Html(
          children: [
            const Text('Hello'),
          ],
      );
      expect(html.render(), '<html>Hello</html>');
    });
  });
}
