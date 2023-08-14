class PerformanceScore {
  int tempo;
  int bodyMovement;
  int tracing;
  int blocks;
  int locks;

  int get total =>
      tempo + bodyMovement + tracing + blocks + locks;

  PerformanceScore(this.tempo, this.bodyMovement, this.tracing,
      this.blocks, this.locks)
      : assert(tempo <= 5),
        assert(bodyMovement <= 5),
        assert(tracing <= 5),
        assert(blocks <= 5),
        assert(locks <= 5);
}