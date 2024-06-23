
class Product {
  final int id;
  final int? productId;
  final String name;
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
    required this.id,
    this.productId,
    required this.name,
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
      id: json['id'] as int,
      productId: json['productId'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool?,
      liked: json['liked'] as int?,
      isHighlight: json['isHighlight'] as bool?,
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      userSurname: json['userSurname'] as String?,
      userCity: json['userCity'] as String?,
      userRating: (json['userRating'] as num?)?.toDouble() ?? 0.0,
      commentCount: json['commentCount'] as int?,
      brandId: json['brandId'] as int?,
      brandName: json['brandName'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String?,
      maxRentalPeriod: json['maxRentalPeriod'] as int?,
      minRentalPeriod: json['minRentalPeriod'] as int?,
      filE_URL_1: json['filE_URL_1'] as String?,
      filE_URL_2: json['filE_URL_2'] as String?,
      filE_URL_3: json['filE_URL_3'] as String?,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      subCategoryId: json['subCategoryId'] as int?,
      subCategoryName: json['subCategoryName'] as String?,
    );
  }


}
