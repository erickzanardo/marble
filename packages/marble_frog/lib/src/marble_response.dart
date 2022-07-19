import 'package:dart_frog/dart_frog.dart';
import 'package:marble/marble.dart';

/// {@template marble_response}
/// A response from a marble.
/// {@endtemplate}
class MarbleResponse extends Response {
  /// {@macro marble_response}
  MarbleResponse(Html page)
      : super(
          body: page.render(),
          headers: {
            'content-type': 'text/html',
          },
        );
}
