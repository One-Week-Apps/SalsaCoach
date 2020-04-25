class Achievement {
  final String uid;
  final String name;
  final String description;
  Achievement(this.uid, this.name, this.description);

  @override
  String toString() => '$uid, $name, $description';
}
