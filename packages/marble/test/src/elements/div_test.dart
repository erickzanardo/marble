import 'package:marble/marble.dart';
import 'package:test/test.dart';

void main() {
  group('Div', () {
    test('render an empty tag', () {
      final div = Div();
      expect(div.render(), '<div/>');
    });

    test('render its children', () {
      final div = Div(
        children: [
          Div(),
        ],
      );
      expect(div.render(), '<div><div/></div>');
    });

    test('render its attributes', () {
      final div = Div(
          id: 'my-element',
          className: 'my-class',
      );
      expect(div.render(), '<div id="my-element" class="my-class"/>');
    });

    test('render a text', () {
      final div = Div(
          children: [
            const Text('Hello'),
          ],
      );
      expect(div.render(), '<div>Hello</div>');
    });
  });
}
