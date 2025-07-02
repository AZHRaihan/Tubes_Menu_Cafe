class MenuItem {
  final String id;
  final String name;
  final String category; // "food" atau "drink"
  final double price;
  final String image; // path asset gambar

  const MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });
}
