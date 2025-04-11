class ProductModel{

  int id;
  String name;
  String description;
  double price;
  double? discount;
  String Image;
  bool? isAddedFav = false;

  ProductModel({
    required this.id,
    required this.name,
    required this.description, 
    required this.price,
    required this.discount,
    required this.Image,
    required this.isAddedFav,
  });

  // Add the fromJson factory constructor
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['description']['name'],
      description: json['description']['description'],
      price: double.parse(json['price'].toString()),
      discount: json['discount_price'] != null
          ? double.parse(json['discount_price'].toString())
          : null,
      Image: json['image'],
      isAddedFav: json['is_exisit_favourite'] == 0 ? false : true,
    );
  }

}