abstract class GameEvent {}

class InitializeGame extends GameEvent {}

class FlipCard extends GameEvent {
  final int index;
  FlipCard(this.index);
}

class SetDifficulty extends GameEvent {
  final int rows;
  final int cols;
  SetDifficulty(this.rows, this.cols);
}

class ResetGame extends GameEvent {}
