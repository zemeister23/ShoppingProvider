class MarketModel {
  MarketModel({
    this.name,
    this.price,
    this.image,
    this.category,
  });

  String? name;
  int? price;
  String? image;
  String? category;

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        name: json["name"],
        price: json["price"],
        image: json["image"],
        category: json["category"],
      );
}
