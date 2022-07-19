# Marble

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Dart engine to generate HTML

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

Marble is a dart engine, focused on generating HTML pages based on a declarative, typesafe API.

It can be used to generate static web sites, or used on a backend to create SSR pages.

## Usage example:

```dart
import 'package:marble/marble.dart';

void main() {
  final page = Html(
    children: Body(
      children: [
        Text('Hello Marble World!'),
      ],
    ),
  );
}
```
