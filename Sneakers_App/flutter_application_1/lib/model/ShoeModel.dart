class Shoe {
  final String name;
  final String imagePath;
  final String price;
  final String description;
  final String size;

  Shoe({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.size
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Shoe &&
        other.name == name &&
        other.imagePath == imagePath &&
        other.price == price &&
        other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ imagePath.hashCode ^ price.hashCode ^ description.hashCode;
}
