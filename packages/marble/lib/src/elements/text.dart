import 'package:marble/marble.dart';

/// {@template text}
/// A text that usuallys goes inside an [Element].
/// {@endtemplate}
class Text extends Node {
  /// {@macro text}
  const Text(this.text);

  /// The text value of this [Text].
  final String text;

  @override
  String render() => text;
}
