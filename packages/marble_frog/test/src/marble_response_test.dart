import 'package:marble/marble.dart';
import 'package:marble_frog/marble_frog.dart';
import 'package:test/test.dart';

void main() {
  group('MarbleResponse', () {
    test('correctly build a response object from a Html', () async {
      final page = Html(
          children: [
            Body(
                children: [
                  const Text('Works'),
                ],
            ),
          ],
      );

      final response = MarbleResponse(page);
      expect(response.headers['content-type'], equals('text/html'));
      expect(await response.body(), equals(page.render()));
    });
  });
}
