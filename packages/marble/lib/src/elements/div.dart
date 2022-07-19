import 'package:marble/marble.dart';

/// {@template div}
/// A generic container for flow content.
/// {@endtemplate}
class Div extends Element {

  /// {@macro div}
  Div({
    super.children,
    super.id,
    super.className,
  }) : super(tagName: 'div');
}
