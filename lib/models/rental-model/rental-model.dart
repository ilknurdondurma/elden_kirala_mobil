class Rental{
  final int? id;
  final int? productId;
  final int? receiverUserId;
  final int? salesUserId;
  final bool? rentalStatus;
  final String? startDate;
  final String? endDate;
  final double? rentalPrice;
  final int? rentalPeriod;
  final bool? paymentStatus;

  Rental({
  this.id,
  this.productId,
  this.receiverUserId,
  this.salesUserId,
  this.rentalStatus,
  this.startDate,
  this.endDate,
  this.rentalPrice,
  this.rentalPeriod,
  this.paymentStatus

  });

  factory Rental.fromJson(Map<String , dynamic> json){
    return Rental(
      id: json['id'] as int?,
      productId: json['productId'] as int?,
      receiverUserId: json['receiverUserId'] as int?,
      salesUserId: json['salesUserId'] as int?,
      rentalStatus: json['rentalStatus'] as bool?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      rentalPrice: json['rentalPrice'] as double?,
      rentalPeriod: json['rentalPeriod'] as int?,
      paymentStatus: json['paymentStatus'] as bool?,
    );
  }

}