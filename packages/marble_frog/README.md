# marble_frog

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Provides marble support to dart frog

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

## Example

```dart
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
```
