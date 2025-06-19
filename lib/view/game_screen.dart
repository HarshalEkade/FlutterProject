import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/game_bloc.dart';
import '../controller/game_event.dart';
import '../controller/game_state.dart';
import '../model/card_model.dart';
import '../utils/storage.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, int>> difficulties = [
    {'Easy': 2},
    {'Medium': 4},
    {'Hard': 6},
  ];

  String _selectedDifficulty = 'Medium';

  void _onDifficultyChanged(String? value) {
    if (value != null) {
      setState(() => _selectedDifficulty = value);
      final size =
          difficulties.firstWhere((d) => d.containsKey(value)).values.first;
      context.read<GameBloc>().add(SetDifficulty(size, size));
    }
  }

  void _showScoreHistory() async {
    final history = await ScoreStorage.getScoreHistory();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Score History'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (_, index) {
                  final score = history[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.history,
                      color: Colors.deepPurple,
                    ),
                    title: Text('⏱ Time: ${score.score}s'),
                    subtitle: Text(score.timestamp),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 80, 242),
        title: Text(
          '🧠 Memory Match Game',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            tooltip: "View Score History",
            onPressed: _showScoreHistory,
            icon: const Icon(Icons.leaderboard, color: Colors.black),
          ),
          IconButton(
            tooltip: "Reset Game",
            onPressed: () => context.read<GameBloc>().add(ResetGame()),
            icon: const Icon(Icons.refresh, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          // Difficulty Selector
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Difficulty:", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedDifficulty,
                  borderRadius: BorderRadius.circular(10),
                  items:
                      difficulties.map((d) {
                        String label = d.keys.first;
                        return DropdownMenuItem(
                          value: label,
                          child: Text('$label (${d[label]}x${d[label]})'),
                        );
                      }).toList(),
                  onChanged: _onDifficultyChanged,
                ),
              ],
            ),
          ),

          // Game Grid
          BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              final totalCards = state.cards.length;
              final gridSize = totalCards > 0 ? sqrt(totalCards).toInt() : 2;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: totalCards,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) {
                      final card = state.cards[index];

                      return GestureDetector(
                        onTap:
                            () => context.read<GameBloc>().add(FlipCard(index)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color:
                                card.isMatched
                                    ? Colors.green[400]
                                    : card.isFlipped
                                    ? Colors.orange[300]
                                    : Colors.blue[300],
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: card.isFlipped || card.isMatched ? 1 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                card.content,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // Game Stats
          BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(
                      'Moves',
                      state.moves.toString(),
                      Icons.touch_app,
                    ),
                    _buildStat('Time', '${state.time}s', Icons.timer),
                    _buildStat(
                      'Best',
                      state.bestScore == 0 ? "-" : '${state.bestScore}s',
                      Icons.emoji_events,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 107, 55, 189)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
