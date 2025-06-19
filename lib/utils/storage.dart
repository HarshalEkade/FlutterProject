import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../model/score_model.dart';

class ScoreStorage {
  static Future<void> setBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestScore', score);
  }

  static Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('bestScore') ?? 0;
  }

  static Future<void> saveScoreHistory(int score, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('scoreHistory') ?? [];
    final list =
        historyJson.map((e) => ScoreModel.fromJson(json.decode(e))).toList();
    list.add(
      ScoreModel(
        score: score,
        timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(time),
      ),
    );
    final updated = list.map((s) => json.encode(s.toJson())).toList();
    await prefs.setStringList('scoreHistory', updated);
  }

  static Future<List<ScoreModel>> getScoreHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('scoreHistory') ?? [];
    return historyJson.map((e) => ScoreModel.fromJson(json.decode(e))).toList();
  }
}
