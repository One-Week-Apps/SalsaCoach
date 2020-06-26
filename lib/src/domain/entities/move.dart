class Move {
  final String name;
  final String tempo;
  final String description;
  final String urlString;
  final int difficulty;
  bool isLiked = false;

  Move(
      this.name, this.tempo, this.description, this.urlString, this.difficulty);

  @override
  String toString() =>
      '$name, $tempo, $description, $urlString, $difficulty, $isLiked';
}
