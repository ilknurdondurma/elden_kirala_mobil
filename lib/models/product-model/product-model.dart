class Product {
  final int? id;
  final int? productId;
  final String? name;
  final String? description;
  final double? price;
  final bool? isActive;
  final int? liked;
  final bool? isHighlight;
  final int? userId;
  final String? userName;
  final String? userSurname;
  final String? userCity;
  final double? userRating;
  final int? commentCount;
  final int? brandId;
  final String? brandName;
  final double? rating;
  final String? status;
  final int? maxRentalPeriod;
  final int? minRentalPeriod;
  final String? filE_URL_1;
  final String? filE_URL_2;
  final String? filE_URL_3;
  final int? categoryId;
  final String? categoryName;
  final int? subCategoryId;
  final String? subCategoryName;

  Product({
    this.id,
    this.productId,
    this.name,
    this.description,
    this.price,
    this.isActive,
    this.liked,
    this.isHighlight,
    this.userId,
    this.userName,
    this.userSurname,
    this.userCity,
    this.userRating,
    this.commentCount,
    this.brandId,
    this.brandName,
    this.rating,
    this.status,
    this.maxRentalPeriod,
    this.minRentalPeriod,
    this.filE_URL_1,
    this.filE_URL_2,
    this.filE_URL_3,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? "",
      productId: json['productId'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      isActive: json['isActive'] ?? "",
      liked: json['liked'] ?? "",
      isHighlight: json['isHighlight'] ?? "",
      userId: json['userId'] ?? "",
      userName: json['userName'] ?? "",
      userSurname: json['userSurname'] ?? "",
      userCity: json['userCity'] ?? "",
      userRating: json['userRating'] != null ? json['userRating'].toDouble() : 0.0,
      commentCount: json['commentCount'] ?? "",
      brandId: json['brandId'] ?? "",
      brandName: json['brandName'] ?? "",
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
      status: json['status'] ?? "",
      maxRentalPeriod: json['maxRentalPeriod'] ?? "",
      minRentalPeriod: json['minRentalPeriod'] ?? "",
      filE_URL_1: json['filE_URL_1'] ?? "",
      filE_URL_2: json['filE_URL_2'] ?? "",
      filE_URL_3: json['filE_URL_3'] ?? "",
      categoryId: json['categoryId'] ?? "",
      categoryName: json['categoryName'] ?? "",
      subCategoryId: json['subCategoryId'] ?? "",
      subCategoryName: json['subCategoryName'] ?? "",
    );

  }
}
