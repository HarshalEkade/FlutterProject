import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/card_model.dart';
import '../utils/storage.dart';
import '../utils/sound.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  List<CardModel> _cards = [];
  Timer? _timer;
  int _moves = 0;
  int _seconds = 0;
  int _rows = 4;
  int _cols = 4;
  int? _firstIndex;
  int? _secondIndex;

  GameBloc() : super(GameState(cards: [], moves: 0, time: 0, bestScore: 0)) {
    on<InitializeGame>(_onInit);
    on<FlipCard>(_onFlip);
    on<SetDifficulty>(_onSetDifficulty);
    on<ResetGame>(_onReset);
  }

  /// Initializes the game board
  Future<void> _onInit(InitializeGame event, Emitter<GameState> emit) async {
    _moves = 0;
    _seconds = 0;
    _firstIndex = null;
    _secondIndex = null;
    _timer?.cancel();
    _startTimer();

    final totalPairs = (_rows * _cols) ~/ 2;
    final emojis = [
      '🐶',
      '🐱',
      '🦊',
      '🐻',
      '🐸',
      '🦁',
      '🐷',
      '🐵',
      '🐨',
      '🐯',
      '🐰',
      '🐮',
      '🐔',
      '🦄',
      '🐙',
      '🐳',
    ];
    final selected = emojis.take(totalPairs).toList();
    final shuffled = [...selected, ...selected]..shuffle(Random());
    _cards = List.generate(
      shuffled.length,
      (i) => CardModel(id: i, content: shuffled[i]),
    );
    final best = await ScoreStorage.getBestScore();

    emit(
      GameState(
        cards: [..._cards],
        moves: _moves,
        time: _seconds,
        bestScore: best,
      ),
    );
  }

  /// Handles card flip and match logic
  Future<void> _onFlip(FlipCard event, Emitter<GameState> emit) async {
    if (_firstIndex != null && _secondIndex != null) return;
    if (_cards[event.index].isFlipped || _cards[event.index].isMatched) return;

    Sound.playFlip();
    _cards[event.index].isFlipped = true;

    emit(_buildState());

    if (_firstIndex == null) {
      _firstIndex = event.index;
    } else {
      _secondIndex = event.index;
      _moves++;

      await Future.delayed(const Duration(milliseconds: 700));

      final firstCard = _cards[_firstIndex!];
      final secondCard = _cards[_secondIndex!];

      if (firstCard.content == secondCard.content) {
        _cards[_firstIndex!].isMatched = true;
        _cards[_secondIndex!].isMatched = true;
        Sound.playMatch();
      } else {
        _cards[_firstIndex!].isFlipped = false;
        _cards[_secondIndex!].isFlipped = false;
      }

      _firstIndex = null;
      _secondIndex = null;

      final allMatched = _cards.every((card) => card.isMatched);
      if (allMatched) {
        _timer?.cancel();
        await ScoreStorage.saveScoreHistory(_seconds, DateTime.now());

        int bestScore = state.bestScore;
        if (bestScore == 0 || _seconds < bestScore) {
          bestScore = _seconds;
          await ScoreStorage.setBestScore(_seconds);
        }

        emit(_buildState(bestScore: bestScore));
        return;
      }

      emit(_buildState());
    }
  }

  /// Changes game grid size and restarts
  void _onSetDifficulty(SetDifficulty event, Emitter<GameState> emit) {
    _rows = event.rows;
    _cols = event.cols;
    add(InitializeGame());
  }

  /// Resets game with same difficulty
  void _onReset(ResetGame event, Emitter<GameState> emit) {
    add(InitializeGame());
  }

  /// Starts game timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _seconds++;
      emit(_buildState());
    });
  }

  /// Emits current game state
  GameState _buildState({int? bestScore}) {
    return GameState(
      cards: [..._cards],
      moves: _moves,
      time: _seconds,
      bestScore: bestScore ?? state.bestScore,
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
