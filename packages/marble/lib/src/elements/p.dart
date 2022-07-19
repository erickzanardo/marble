import 'package:marble/marble.dart';

/// {@template p}
/// A paragraph element.
/// {@endtemplate}
class P extends Element {

  /// {@macro p}
  P({
    super.children,
    super.id,
    super.className,
  }) : super(tagName: 'p');
}
