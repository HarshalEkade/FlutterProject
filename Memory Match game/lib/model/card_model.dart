class CardModel {
  final int id;
  final String content;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.id,
    required this.content,
    this.isFlipped = false,
    this.isMatched = false,
  });
}
