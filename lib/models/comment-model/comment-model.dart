class Comment{
  final int? id;
  final int? userId;
  final  String? userName;
  final String? userSurname;
  final double? userRating;
  final String? commentContent;
  final int? productId;
  final String? productName;
  final String? createdDate;

  Comment({
    this.id,
    this.userId,
    this.userName,
    this.userSurname,
    this.userRating,
    this.commentContent,
    this.productId,
    this.productName,
    this.createdDate
});
  factory Comment.fromJson(Map<String , dynamic> json){
    return Comment(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      userSurname: json['userSurname'] as String?,
      userRating: json['userRating'] != null ? (json['userRating'] as num).toDouble() : 0.0,
      commentContent: json['commentContent'] as String?,
      productId: json['productId'] as int?,
      productName: json['productName'] as String?,
      createdDate: json['createdDate'] as String?,
    );

  }
}