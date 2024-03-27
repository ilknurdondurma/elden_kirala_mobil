import 'package:elden_kirala/components/stars/stars.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/models/comment-model/comment-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../api/api.dart';
import '../../constanst/colors.dart';
import '../../services/fetcher.dart';
import '../text/text.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.productId});
  final int productId;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  List<Comment> comments = [];
  final ScrollController _controller = ScrollController();
  late Fetcher commentFetcher;

  @override
  void initState() {
    super.initState();
    commentFetcher = Fetcher(Comment.fromJson, _setComments, () => Api.getCommentById(widget.productId));
    commentFetcher.fetchData();
   ;
  }

  void _setComments(List<dynamic> data) {
    setState(() {
      comments = data.cast<Comment>(); // Comment tipine dönüştürme
    });
  }
  String formatDate(DateTime dateTime) {
    // Tarihi gün/ay/yıl formatına çevir
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString();

    return '$day/$month/$year';
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Container(
        child:  comments.isEmpty && commentFetcher.isLoading // API'den veri bekleniyor
            ? Center(child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF61D4AF),
          rightDotColor: const Color(0xFF673ab7),
          size: 20,
        ),)
            : comments.isEmpty // Ürün bulunamadı
            ? Container(
                width: MyContainerSizes.widthSize(context, 0.95),
                height: MyContainerSizes.heightSize(context, 0.10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: MyColors.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CreateStar(rate: 0),
                      Text("Değerlendirme bulunamadı",style: TextStyle(fontSize: MyFontSizes.fontSize_1(context)),),
                    ],
                  ),))
            :Column(
                children:
                  comments.map((comment) {
                    DateTime date = DateTime.parse('${comment.createdDate}');
                    return GestureDetector(
                      onTap: ()=>print(formatDate(date)),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: MyColors.tertiary),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CreateStar(
                                      rate: comment.userRating!.toDouble(),
                                      size: 15,

                                  ),
                                  Text('${comment.userName} ${comment.userSurname}',style: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(formatDate(date),style: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(child: Text(comment.commentContent!,)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),


              ),


      ),
    );
  }
}
