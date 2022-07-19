import 'package:marble/marble.dart';
import 'package:test/test.dart';

void main() {
  group('Body', () {
    test('render an empty tag', () {
      final body = Body();
      expect(body.render(), '<body/>');
    });

    test('render its children', () {
      final body = Body(
        children: [
          Body(),
        ],
      );
      expect(body.render(), '<body><body/></body>');
    });

    test('render its attributes', () {
      final body = Body(
          id: 'my-element',
          className: 'my-class',
      );
      expect(body.render(), '<body id="my-element" class="my-class"/>');
    });

    test('render a text', () {
      final body = Body(
          children: [
            const Text('Hello'),
          ],
      );
      expect(body.render(), '<body>Hello</body>');
    });
  });
}
