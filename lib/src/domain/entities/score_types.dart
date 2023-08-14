enum ScoreTypes {
  tempo,
  bodyMovement,
  tracing,
  blocks,
  locks
}

extension ScoreTypesExtension on ScoreTypes {
  static const _names = {
    ScoreTypes.tempo: 'Tempo',
    ScoreTypes.bodyMovement: 'Body Movement',
    ScoreTypes.tracing: 'Tracing',
    ScoreTypes.blocks: 'Blocks',
    ScoreTypes.locks: 'Locks',
  };

  String get rawValue => _names[this] ?? "Generic";
}
