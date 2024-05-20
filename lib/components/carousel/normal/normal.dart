import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constanst/colors.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> items;
  final bool? isHaveImage;
  final bool? border;
  final int? countOfWidth; // ekranda yanyana kactane görünecek

  final Function(int) onItemSelected; // onCategorySelected parametresi eklendi

  const Carousel({Key? key, required this.items, required this.onItemSelected, this.isHaveImage=false, this.border, this.countOfWidth}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int selectedIndex = 3;
  void selectedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index); // Yeni callback fonksiyonu çağır

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: widget.items.asMap().entries.map((entry) {
            int index = entry.value.id;
            dynamic item = entry.value; // index e id verdik
            return GestureDetector(
              onTap: () {
                if(selectedIndex==index){
                  selectedItem(-1);

                }
                else{
                  selectedItem(index);
                  print(index);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 0,left: 0,right: 8,top: 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: widget.border==true
                        ?Border.all(width: 1, color: MyColors.tertiary)
                        :index==selectedIndex?Border.all(width: 1, color: MyColors.tertiary):null,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    gradient: widget.isHaveImage == true
                        ? null
                        :
                          index == selectedIndex
                              ? const LinearGradient(
                                  colors: [MyColors.secondary, Colors.deepPurple, Colors.deepPurpleAccent],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 0.5, 1.0],
                                  tileMode: TileMode.clamp,
                                )
                              : null,
                  ),
                  width: MediaQuery.of(context).size.width / (widget.countOfWidth?? 5),
                  height: MediaQuery.of(context).size.width / 12,
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      //heightFactor: 0.5,
                      child: Container(
                          child: widget.isHaveImage==true
                          ? Center(
                                child: FractionallySizedBox(
                                widthFactor: 0.9,
                                heightFactor: 1,
                                child: Image.network(
                                  item.logo.toString(),
                                  fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : Text(
                                item.name.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MyFontSizes.fontSize_0(context),
                                  color: index == selectedIndex ? Colors.white : Colors.black,
                            ),
                          ),
            ),

            ),
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
