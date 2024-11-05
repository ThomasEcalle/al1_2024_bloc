class Product {
  final int id;
  final String title;
  final double price;

  const Product({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
    );
  }
}
