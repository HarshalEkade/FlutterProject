class ScoreModel {
  final int score;
  final String timestamp;

  ScoreModel({required this.score, required this.timestamp});

  Map<String, dynamic> toJson() => {'score': score, 'timestamp': timestamp};

  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      ScoreModel(score: json['score'], timestamp: json['timestamp']);
}
