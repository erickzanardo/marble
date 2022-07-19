import 'package:marble/marble.dart';

/// {@template body}
/// The container for the body content of the page.
/// {@endtemplate}
class Body extends Element {

  /// {@macro body}
  Body({
    super.children,
    super.id,
    super.className,
  }) : super(tagName: 'body');
}
