class User {
  final int? id;
  final String? name;
  final String? surname;
  final String? token;
  final String? email;
  final double? rating;
  final DateTime? createdDate;
  final String? city;
  final String? district;
  final String? userType;

  User({
      this.id,
      this.name,
      this.surname,
      this.token,
      this.email,
      this.rating,
      this.createdDate,
      this.city,
      this.district,
      this.userType,

  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
    id:json['id'] as int?,
    name:json['name'] as String?,
    surname:json['surname'] as String?,
    token:json['token'] as String?,
    email:json['email'] as String?,
    rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
    createdDate:json['createdDate'] as DateTime?,
    city:json['city'] as String?,
    district:json['district'] as String?,
    userType:json['userType'] as String?
  );
  }
}
