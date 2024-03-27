import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api/api.dart';
import '../../../components/dropdown/dropdown.dart';
import '../../../constanst/colors.dart';
import '../../../constanst/fontSize.dart';
import '../../../models/brand-model/brand-model.dart';
import '../../../models/category-model/category-model.dart';
import '../../../services/fetcher.dart';
final box = GetStorage();

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<Brand> brands = [];
  List<Categories> categories = [];
  late Fetcher brandFetcher;
  late Fetcher categoryFetcher;
  late String userId = box.read('user')['id'].toString();
  final TextEditingController _textController = TextEditingController();
  late String _selectedItem = '';
  late String _selectedItem2 = '';


  @override
  void initState() {
    super.initState();
    brandFetcher = Fetcher(Brand.fromJson, _setBrands, () => Api.getAllBrand());
    categoryFetcher = Fetcher(Categories.fromJson, _setCategories, () => Api.getCategories());

    brandFetcher.fetchData();
    categoryFetcher.fetchData();
  }

  void _setBrands(List<dynamic> data) {
    setState(() {
      brands = data.cast<Brand>();
      if (brands.isNotEmpty) {
        _selectedItem2 = brands.first.name!;
      }
    });
  }

  void _setCategories(List<dynamic> data) {
    setState(() {
      categories = data.cast<Categories>();
      if (categories.isNotEmpty) {
        _selectedItem = categories.first.name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: MyContainerSizes.heightSize(context, 0.9),
              width: MyContainerSizes.widthSize(context, 0.9),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: MyColors.tertiary),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Text(
                    MyTexts.addProduct,
                    style: TextStyle(
                      fontSize: MyFontSizes.fontSize_3(context),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  CustomDropdownContainer(
                    selectedItem: _selectedItem,
                    items: categories.map((category) => category.name).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedItem = value;
                        });
                      }
                    },
                  ),
                  CustomDropdownContainer(
                    selectedItem: _selectedItem2,
                    items: brands.map((brand) => brand.name!).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedItem2 = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
