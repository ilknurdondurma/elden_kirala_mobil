import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBarInPage(title: MyTexts.favorites,),
      body:  Center(
        child: Container(
          child: Text("favorites"),
        ),
      ),
    );
  }
}
