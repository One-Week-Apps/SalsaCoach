class Move {
  final String name;
  final String tempo;
  final String description;
  final String urlString;
  Move(this.name, this.tempo, this.description, this.urlString);

  @override
  String toString() => '$name, $tempo, $description, $urlString';
}
