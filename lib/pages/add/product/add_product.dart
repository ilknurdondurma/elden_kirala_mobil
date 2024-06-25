import 'dart:io';
import 'dart:convert';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/material.dart';
import '../../../components/buttons/button.dart';
import '../../../components/imagePicker/image_picker.dart';
import '../../../components/textField/custom_input_field.dart';
import '../../../constanst/colors.dart';
import '../../../constanst/fontSize.dart';
import '../../../models/brand-model/brand-model.dart';
import '../../../models/category-model/category-model.dart';
import '../../../services/fetcher.dart';

import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../../api/api.dart';
import '../../../controller/auth-controller/auth-controller.dart';
final box = GetStorage();


class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  List<Brand> brands = [];
  List<Categories> categories = [];
  late List subCategories = [];
  late Fetcher brandFetcher;
  late Fetcher categoryFetcher;
  late String userId = box.read('user')['id'].toString();
  final headerController = TextEditingController();
  final descriptionController = TextEditingController();
  final minRentalController = TextEditingController();
  final maxRentalController = TextEditingController();
  final priceController = TextEditingController();
  final buttonData = [
    { 'id': 1, 'variant': "PurpleOutline", 'label': 'Çok İyi'},
    { 'id': 2, 'variant': "PurpleOutline", 'label': 'İyi'},
    { 'id': 3, 'variant': "PurpleOutline", 'label': 'Orta'},
    { 'id': 4, 'variant': "PurpleOutline", 'label': 'Kötü'},
  ];

  List<File?> selectedFiles = [];
  String selectedState = '';
  bool isHighlights = false;
  late int? selectedCategory = null;
  late int? selectedSubCategory = null;
  late int? selectedBrand = null;

  @override
  void initState() {
    super.initState();
    categoryFetcher =
        Fetcher(Categories.fromJson, _setCategories, () => Api.getCategories());
    categoryFetcher.fetchData();
  }

  void _setCategories(List<dynamic> data) {
    setState(() {
      categories = data.cast<Categories>();
    });
  }

  void _setBrands(List<dynamic> data) {
    setState(() {
      brands = data.cast<Brand>();
      if (brands.isNotEmpty) {}
    });
  }

  void handleChangeCategory(int catId) async {
    try {
      // Fetch brands by category ID
      brandFetcher = Fetcher(
          Brand.fromJson, _setBrands, () => Api.getBrandByCategoryId(catId));
      await brandFetcher.fetchData();

      if (brands.isEmpty) {
        setState(() {
          brands.add(Brand(id: 1035, name: "Diğer"));
        });
      }

      // Update subCategories
      List subCats = categories
          .firstWhere((cat) => cat.id == catId)
          .subCategories ?? [];

      setState(() {
        subCategories = subCats;
      });

      if (subCategories.isNotEmpty) {
        print('Updated subCategories: ${subCategories.map((subCat) => subCat.id)
            .toList()}');
      } else {
        print('No subcategories found for category ID: $catId');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleSubmit() async {
    print(headerController.text);
    print(descriptionController.text);
    print(priceController.text);
    print(userId);
    print(selectedState);
    print(maxRentalController.text);
    print(minRentalController.text);
    print(isHighlights);
    print(selectedBrand);
    print(selectedCategory);
    print(selectedSubCategory);

    var product={
      "Name": headerController.text,
      "Description": descriptionController.text,
      "Price": priceController.text,
      "UserId": userId,
      "IsActive": true,
      "Rating": 5,
      "Status": selectedState,
      "MaxRentalPeriod": maxRentalController.text,
      "MinRentalPeriod": minRentalController.text,
      "IsHighlight": isHighlights || false,
      "BrandId":  selectedBrand,
      "CategoryId":selectedCategory,
      "SubCategoryId":selectedSubCategory
    };
    try {
      dio.FormData formData = dio.FormData();
      formData.fields.add(MapEntry('data', jsonEncode(product)));

      for (int i = 0; i < selectedFiles.length; i++) {
        formData.files.add(
          MapEntry(
            'FILE_URL_${i + 1}',
            await dio.MultipartFile.fromFile(selectedFiles[i]!.path),
          ),
        );
      }


      dio.Response response = await Api.addProduct(formData);
      if (response.statusCode == 200) {
        print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
        Map<String, dynamic> responseData = response.data['data'];
      } else {
        print("İstek başarısız oldu. Durum kodu: ${response.statusCode}");
      }
    }  catch (e) {
      print("İstek sırasında bir hata oluştu:");
      ScaffoldMessenger.of(context,).showSnackBar(
        SnackBar(
          content: Text("İstek sırasında bir hata oluştu"),
          duration: Duration(seconds: 2),
        ),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarInPage(title: "İlan Yayınla",),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyColors.tertiary),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: MyColors.tertiary.withOpacity(0.3)
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text("İlan Detayları",
                      style: TextStyle(
                          fontSize: MyFontSizes.fontSize_3(context),
                          fontWeight: FontWeight.w500
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MyContainerSizes.widthSize(context, 0.25),
                            height: MyContainerSizes.heightSize(context, 0.05),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,),
                              borderRadius: BorderRadius.circular(15),
                              color: MyColors.secondary.withOpacity(0.8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<int>(
                                  dropdownColor: MyColors.secondary.withOpacity(
                                      0.6),
                                  isExpanded: true,
                                  isDense: true,
                                  value: selectedCategory,
                                  style: TextStyle(
                                      fontSize: MyFontSizes.fontSize_0(context),
                                      color: Colors.white),
                                  items: categories.map((category) {
                                    return DropdownMenuItem<int>(
                                      value: category.id,
                                      child: Text(category.name,
                                          style: TextStyle(
                                              fontSize: MyFontSizes.fontSize_0(
                                                  context),
                                              color: Colors.white)),
                                    );
                                  }).toList(),
                                  onChanged: (value) async {
                                    selectedCategory = value;
                                    selectedBrand = null;
                                    selectedSubCategory = null;
                                    handleChangeCategory(value!);
                                    setState(() {}); // Update the state after the async call
                                  },
                                  hint: Text('Select a category',
                                      style: TextStyle(
                                          fontSize: MyFontSizes.fontSize_0(
                                              context), color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MyContainerSizes.widthSize(context, 0.25),
                            height: MyContainerSizes.heightSize(context, 0.05),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,),
                              borderRadius: BorderRadius.circular(15),
                              color: MyColors.secondary.withOpacity(0.8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<int>(
                                  isExpanded: true,
                                  dropdownColor: MyColors.secondary.withOpacity(
                                      0.6),
                                  isDense: true,
                                  value: selectedSubCategory,
                                  style: TextStyle(
                                      fontSize: MyFontSizes.fontSize_0(context),
                                      color: Colors.white),
                                  items: subCategories.map((category) {
                                    return DropdownMenuItem<int>(
                                      value: category.id,
                                      child: Text(category.name,
                                          style: TextStyle(
                                              fontSize: MyFontSizes.fontSize_0(
                                                  context),
                                              color: Colors.white)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSubCategory = value;
                                    });
                                  },
                                  hint: Text('Select a subcategory',
                                      style: TextStyle(
                                          fontSize: MyFontSizes.fontSize_0(
                                              context), color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MyContainerSizes.widthSize(context, 0.25),
                            height: MyContainerSizes.heightSize(context, 0.05),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,),
                              borderRadius: BorderRadius.circular(15),
                              color: MyColors.secondary.withOpacity(0.8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<int>(
                                  dropdownColor: MyColors.secondary.withOpacity(
                                      0.6),
                                  isExpanded: true,
                                  isDense: true,
                                  value: selectedBrand,
                                  style: TextStyle(
                                      fontSize: MyFontSizes.fontSize_0(context),
                                      color: Colors.white),
                                  items: brands.map((brand) {
                                    return DropdownMenuItem<int>(
                                      value: brand.id,
                                      child: Text(brand.name.toString(),
                                          style: TextStyle(
                                              fontSize: MyFontSizes.fontSize_0(
                                                  context),
                                              color: Colors.white)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBrand = value;
                                    });
                                  },
                                  hint: Text('Select a brand', style: TextStyle(
                                      fontSize: MyFontSizes.fontSize_0(context),
                                      color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: headerController,
                        label: "İlan Başlığı",
                        placeholder: "İlan Başlığı ..| ",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: descriptionController,
                        label: "İlan Açıklaması",
                        maxLines: 5,
                        placeholder: "İlan Açıklaması ..| ",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vitrine Ekle:",
                          style: TextStyle(
                              fontSize: MyFontSizes.fontSize_1(context),
                              fontWeight: FontWeight.w400
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                         Checkbox(
                          value: isHighlights,
                          onChanged: (value){
                            setState(() {
                              isHighlights=value!;
                            });
                          },
                          checkColor: MyColors.secondary,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            width: 0.2,
                            controller: minRentalController,
                            inputType: TextInputType.number,
                            label: "Min Kiralama Süresi",
                            placeholder: "[ 1-18 ]",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            width: 0.2,
                            controller: maxRentalController,
                            inputType: TextInputType.number,
                            label: "Max Kiralama Süresi",
                            placeholder: "[ 1-18 ]",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextField(
                            width: 0.2,
                            controller: priceController,
                            inputType: TextInputType.number,
                            label: "Fiyat",
                            placeholder: "100 tl",
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Durumu :",
                            style: TextStyle(
                                fontSize: MyFontSizes.fontSize_1(context),
                                fontWeight: FontWeight.w500
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: buttonData.length,
                            itemBuilder: (context, index) {
                              final button = buttonData[index];
                              return CustomButton(
                                label: button['label'].toString(),
                                onPressed: () {
                                  setState(() {
                                    selectedState = button['label'].toString();
                                    print(selectedState);
                                  });
                                },
                                size: 'xsmall',
                                variant: button['label'] == selectedState
                                    ? "Purple"
                                    : button['variant'].toString(),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    CustomImagePicker(
                      imageCount: 3,
                      squareSize: MyContainerSizes.widthSize(context, 0.25),
                      onImagesPicked: (images) {
                        setState(() {
                          selectedFiles = images.map((image) => File(image!.path)).toList();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: buildBottomBar(context)
    );
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: const Border.symmetric(vertical: BorderSide.none,
              horizontal: BorderSide(width: 1, color: MyColors.tertiary)),
          color: MyColors.secondary.withOpacity(0.8)
      ),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomButton(
                  label: 'Ürünü Ekle',
                  onPressed: () =>handleSubmit(),
                  size: 'xsmall',
                  variant: 'PurpleOutline',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
