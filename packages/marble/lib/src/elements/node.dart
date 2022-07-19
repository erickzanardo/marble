/// {@template node}
/// Represents a node in the HTML tree.
/// {@endtemplate}
abstract class Node {
  /// {@macro node}
  const Node();

  /// Returns the text value of this [Node].
  String render();
}
