import '../model/card_model.dart';

class GameState {
  final List<CardModel> cards;
  final int moves;
  final int time;
  final int bestScore;

  GameState({
    required this.cards,
    required this.moves,
    required this.time,
    required this.bestScore,
  });
}
