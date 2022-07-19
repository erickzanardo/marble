import 'package:dart_frog/dart_frog.dart';
import 'package:marble/marble.dart';
import 'package:marble_frog/marble_frog.dart';

Response onRequest(RequestContext context) {
  return MarbleResponse(
    Html(
      children: [
        Body(
          children: [
            Div(
              children: [
                const Text('Hello Marble Frog World'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
