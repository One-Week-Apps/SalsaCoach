class Performance {
  int id;
  DateTime dateTime;
  PerformanceScore score;

  Performance(this.id, this.score, this.dateTime);

  Performance.fromJson(Map<String, dynamic> json)
  : id = json['id'], 
  score = PerformanceScore(0, 0, 0, 0, 0, 0, 0), 
  dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']);
    // dateTime = json['dateTime'],
    // score = json['score'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'dateTime': dateTime.millisecondsSinceEpoch,
    // 'score': [score.tempo.toString(), score.bodyMovement.toString(), score.tracing.toString(), score.hairBrushes.toString(), score.blocks.toString(), score.locks.toString(), score.handToss.toString()]
  };
}

class PerformanceScore {
    int tempo;
    int bodyMovement;
    int tracing;
    int hairBrushes;
    int blocks;
    int locks;
    int handToss;

    PerformanceScore(this.tempo, this.bodyMovement, this.tracing, this.hairBrushes, this.blocks, this.locks, this.handToss) 
    : assert(tempo <= 5),
      assert(bodyMovement <= 5),
      assert(tracing <= 5),
      assert(hairBrushes <= 5),
      assert(blocks <= 5),
      assert(locks <= 5),
      assert(handToss <= 5);
}