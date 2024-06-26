class Message{
  final String? id;
  final int? senderId;
  final int? receiverId;
  final  String? messageContent;
  final int? date;
  final String? clientType;
  final String? userName;
  final String? userSurname;
  final double? userRating;

  Message(
  {
    this.id,
    this.senderId,
    this.receiverId,
    this.messageContent,
    this.date,
    this.clientType,
    this.userName,
    this.userSurname,
    this.userRating
  });
  factory Message.fromJson(Map<String , dynamic> json){
    return Message(
      id: json['id'] as String?,
      senderId: json['senderId'] as int?,
      receiverId: json['receiverId'] as int?,
      messageContent: json['messageContent'] as String?,
      userRating: json['userRating'] != null ? (json['userRating'] as num).toDouble() : 0.0,
      date: json['date'] as int?,
      userName: json['userName'] as String?,
      userSurname: json['userSurname'] as String?,
      clientType: json['clientType'] as String?,
    );

  }
}