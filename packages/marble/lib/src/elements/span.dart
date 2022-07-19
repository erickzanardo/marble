import 'package:marble/marble.dart';

/// {@template span}
/// A generic container for flow content.
/// {@endtemplate}
class Span extends Element {

  /// {@macro span}
  Span({
    super.children,
    super.id,
    super.className,
  }) : super(tagName: 'span');
}
