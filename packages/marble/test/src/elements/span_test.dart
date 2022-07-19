import 'package:marble/marble.dart';
import 'package:test/test.dart';

void main() {
  group('Span', () {
    test('render an empty tag', () {
      final span = Span();
      expect(span.render(), '<span/>');
    });

    test('render its children', () {
      final span = Span(
        children: [
          Span(),
        ],
      );
      expect(span.render(), '<span><span/></span>');
    });

    test('render its attributes', () {
      final span = Span(
          id: 'my-element',
          className: 'my-class',
      );
      expect(span.render(), '<span id="my-element" class="my-class"/>');
    });

    test('render a text', () {
      final span = Span(
          children: [
            const Text('Hello'),
          ],
      );
      expect(span.render(), '<span>Hello</span>');
    });
  });
}
