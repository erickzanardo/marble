import 'package:marble/marble.dart';

/// {@template html}
/// The root element of a page.
/// {@endtemplate}
class Html extends Element {

  /// {@macro html}
  Html({
    super.children,
    super.id,
    super.className,
  }) : super(tagName: 'html');
}
