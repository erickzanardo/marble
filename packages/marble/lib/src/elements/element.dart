import 'package:marble/marble.dart';

/// {@template element}
/// A [Element] is an object that can represents a node in the HTML tree.
/// {@endtemplate}
abstract class Element extends Node {
  /// {@macro element}
  const Element({
    required this.tagName,
    this.children = const [],
    this.id,
    this.className,
  });

  /// The tag name of this element.
  final String tagName;

  /// Element's id.
  final String? id;

  /// Element's classes.
  final String? className;

  /// The [Element]s that are children of this element.
  final List<Node> children;

  /// Returns a Map with app the HTML attributes for this element.
  Map<String, dynamic> getHtmlAttributes() {
    final attributes = <String, dynamic>{};
    attributes['id'] = id;
    attributes['class'] = className;

    return attributes;
  }

  /// Render this element into HTML.
  @override
  String render() {
    final htmlAttributes =
        getHtmlAttributes().entries.where((entry) => entry.value != null);
    final attributes = htmlAttributes.isEmpty
        ? ''
        : ' ${htmlAttributes.map((e) => '${e.key}="${e.value}"').join(' ')}';

    if (children.isEmpty) {
      return '<$tagName$attributes/>';
    } else {
      return '<$tagName$attributes>${children.map((child) => child.render()).join()}</$tagName>';
    }
  }
}
