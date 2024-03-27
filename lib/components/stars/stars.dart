import 'package:flutter/material.dart';

import '../../constanst/fontSize.dart';
import '../detailsCard/detailsCard.dart';

class CreateStar extends StatelessWidget {
  final double rate;
  final double? size;


  const CreateStar({Key? key, required this.rate, this.size=20}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _buildRatingStars(rate,size!),
        ],
      ),
    );
  }
}

Widget _buildRatingStars(double rating,double size) {
  int filledStars = (rating / 2).floor(); // Değeri 2'ye böler ve tam kısmını alır
  bool hasHalfStar = (rating % 2) >= 1; // Değerin 2'ye bölümünden kalanı kontrol eder, 1'den büyükse yarım yıldız vardır
  List<Widget> starIcons = [];

  for (int i = 0; i < filledStars; i++) {
    starIcons.add( Icon(Icons.star, color: Colors.yellow[600], size: size,));
  }

  if (hasHalfStar) {
    starIcons.add( Icon(Icons.star_half, color: Colors.yellow[600], size :size,));
  }

  int emptyStars = 5 - filledStars - (hasHalfStar ? 1 : 0); // Dolu ve yarım yıldızların toplamını 5'ten çıkartır

  for (int i = 0; i < emptyStars; i++) {
    starIcons.add( Icon(Icons.star_border, color: Colors.grey, size:size,));
  }

  return Row(children: starIcons);
}
