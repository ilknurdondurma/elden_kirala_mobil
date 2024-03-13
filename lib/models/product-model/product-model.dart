class ProductModel {
  int? id;
  int? productId;
  String? name;
  String? description;
  double? price;
  bool? isActive;
  int? liked;
  bool? isHighlight;
  int? userId;
  String? userName;
  String? userSurname;
  String? userCity;
  double? userRating;
  int? commentCount;
  int? brandId;
  String? brandName;
  double? rating;
  String? status;
  int? maxRentalPeriod;
  int? minRentalPeriod;
  String?  filEURL1;
  String?  filEURL2;
  String?  filEURL3;
  int? categoryId;
  String? categoryName;
  int? subCategoryId;
  String? subCategoryName;

  ProductModel(
      {this.id,
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
        this.filEURL1,
        this.filEURL2,
        this.filEURL3,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isActive = json['isActive'];
    liked = json['liked'];
    isHighlight = json['isHighlight'];
    userId = json['userId'];
    userName = json['userName'];
    userSurname = json['userSurname'];
    userCity = json['userCity'];
    userRating = json['userRating'];
    commentCount = json['commentCount'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    rating = json['rating'];
    status = json['status'];
    maxRentalPeriod = json['maxRentalPeriod'];
    minRentalPeriod = json['minRentalPeriod'];
    filEURL1 = json['filE_URL_1'];
    filEURL2 = json['filE_URL_2'];
    filEURL3 = json['filE_URL_3'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['isActive'] = this.isActive;
    data['liked'] = this.liked;
    data['isHighlight'] = this.isHighlight;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userSurname'] = this.userSurname;
    data['userCity'] = this.userCity;
    data['userRating'] = this.userRating;
    data['commentCount'] = this.commentCount;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['maxRentalPeriod'] = this.maxRentalPeriod;
    data['minRentalPeriod'] = this.minRentalPeriod;
    data['filE_URL_1'] = this.filEURL1;
    data['filE_URL_2'] = this.filEURL2;
    data['filE_URL_3'] = this.filEURL3;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    return data;
  }
}
