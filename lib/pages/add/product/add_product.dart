import 'dart:io';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api/api.dart';
import '../../../components/buttons/button.dart';
import '../../../components/imagePicker/image_picker.dart';
import '../../../components/textField/custom_input_field.dart';
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
  late List subCategories = [];
  late Fetcher brandFetcher;
  late Fetcher categoryFetcher;

  late String userId = box.read('user')['id'].toString();

  final headerController = TextEditingController();
  final descriptionController = TextEditingController();
  final minRentalController = TextEditingController();
  final maxRentalController = TextEditingController();


  List<File?> selectedImages = [];
  String selectedState = '';

  final buttonData = [
    { 'id': 1, 'variant': "PurpleOutline", 'label': 'Çok İyi' },
    { 'id': 2, 'variant': "PurpleOutline", 'label': 'İyi' },
    { 'id': 3, 'variant': "PurpleOutline", 'label': 'Orta' },
    { 'id': 4, 'variant': "PurpleOutline", 'label': 'Kötü' },
  ];

   int? _selectedCategoryId;
   int? _selectedSubcategoryId;
   int? _selectedBrandId;

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
      }
    });
  }
  void _setCategories(List<dynamic> data) {
    setState(() {
      categories = data.cast<Categories>();
    });
  }



  Future<void> handleSubmit(String formdata, File imageFiles) async {
    // RESİMLERİ CUSTOMIMAGEPICKER DEN NASIL ALCAM
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
              //height: MyContainerSizes.heightSize(context, 0.9),
              //width: MyContainerSizes.widthSize(context, 0.9),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: MyColors.tertiary),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: MyColors.tertiary.withOpacity(0.3)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
              //title
                  Text( "İlan Detayları",
                    style: TextStyle(
                        fontSize: MyFontSizes.fontSize_3(context),
                        fontWeight: FontWeight.w500

                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,),
                  const SizedBox(height: 5,),









              //dropdownlar
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
                                dropdownColor: MyColors.secondary.withOpacity(0.6),
                                isExpanded: true,
                                isDense: true,
                                style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),
                                value: _selectedCategoryId,
                                items: categories.map((category) {
                                  return DropdownMenuItem<int>(
                                    value: category.id,
                                    child: Text(category.name,style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() async {
                                    _selectedCategoryId = value;
                                    _selectedSubcategoryId = null; // Ana kategori değiştiğinde alt kategoriyi temizle
                                    brands=await Api.getBrandByCategoryId(value);
                                  });
                                },
                                hint: Text('Select a category',style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_selectedCategoryId != null && categories.any((category) => category.id == _selectedCategoryId && category.subCategories != null))
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
                                  dropdownColor: MyColors.secondary.withOpacity(0.6),
                                  isDense: true,
                                  style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),
                                  value: _selectedSubcategoryId,
                                  items: categories
                                      .firstWhere((category) => category.id == _selectedCategoryId).subCategories
                                      .map<DropdownMenuItem<int>>((subcategory) {
                                    return DropdownMenuItem<int>(
                                      value: subcategory.id,
                                      child: Text(subcategory.name,style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSubcategoryId = value;
                                    });
                                  },
                                  hint: Text('Select a subcategory',style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_selectedCategoryId != null && categories.any((category) => category.id == _selectedCategoryId ))
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MyContainerSizes.widthSize(context, 0.25),
                          height: MyContainerSizes.heightSize(context, 0.05),                          decoration: BoxDecoration(
                          border: Border.all(width: 0.5,),
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.secondary.withOpacity(0.8),
                        ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<int>(
                                dropdownColor: MyColors.secondary.withOpacity(0.6),
                                isExpanded: true,
                                isDense: true,
                                style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),
                                value: _selectedBrandId,
                                items: brands.map((brand) {
                                  return DropdownMenuItem<int>(
                                    value: brand.id,
                                    child: Text(brand.name.toString(),style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBrandId = value;
                                  });
                                },
                                hint: Text('Select a brand',style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                      ),












                      /*CustomDropdownContainer(
                        label: "Marka : ",
                        width: 0.25,
                        selectedItem: _selectedItemBrand,
                        items: brands.map((brand) => brand.name!).toList(),
                        onChanged: onBrandSelected,
                      ),*/

                    ],
                  ),

















              //baslık
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: headerController,
                      label: "İlan Başlığı",
                      placeholder: "İlan Başlığı ..| ",
                    ),
                  ),
              //acıklama
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: descriptionController,
                      label: "İlan Açıklaması",
                      maxLines: 5,
                      placeholder: "İlan Açıklaması ..| ",
                    ),
                  ),
              //vitrin 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vitrine Ekle:",
                        style: TextStyle(
                            fontSize: MyFontSizes.fontSize_1(context),
                            fontWeight: FontWeight.w400

                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,),
                      const Checkbox(
                          value: false,
                          onChanged: null,
                        checkColor: MyColors.secondary,

                      )
                    ],
                  ),
              //kiralama süre
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          width: 0.3,
                          controller: minRentalController,
                          number: true,
                          label: "Min Kiralama Süresi",
                          placeholder: "[ 1-18 ]",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          width: 0.3,
                          controller: maxRentalController,
                          number: true,
                          label: "Max Kiralama Süresi",
                          placeholder: "[ 1-18 ]",
                        ),
                      )
                    ],
                  ),
              //durumu
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
                          textAlign: TextAlign.center,),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: buttonData.length,
                          itemBuilder: (context, index) {
                            final button = buttonData[index];
                            return Button(
                              label: button['label'].toString(),
                              onPressed: () {
                                setState(() {
                                  selectedState = button['label'].toString();
                                  print(selectedState);
                                });
                              },
                              size: 'xsmall',
                              variant: button['label']==selectedState ?"Purple": button['variant'].toString(),
                            );
                          },
                        )

                      ],
                    ),
                  ),
              //resimler
                  CustomImagePicker(
                    imageCount: 3,
                    squareSize: MyContainerSizes.widthSize(context, 0.25),
                    onImagesPicked: (images) {
                      setState(() {
                        selectedImages = images;
                      });
                    },
                  )












                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:buildBottomBar(context)
    );
  }
}

Container buildBottomBar(BuildContext context) {
  return Container(
    decoration:  BoxDecoration(
      border: const Border.symmetric(vertical:BorderSide.none,horizontal: BorderSide(width: 1,color: MyColors.tertiary)),
      color: MyColors.secondary.withOpacity(0.8)
    ),
    height: MediaQuery.of(context).size.height*0.06,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Button(
                label: 'Ürünü Ekle',
                onPressed: () { },
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
/*
* CustomDropdownContainer(
                        label: "Kategori : ",
                        width: 0.25,
                        value: _selectedCategoryId,
                        items: categories.map((category) => category.name).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _selectedItemCategory = value;
                              _selectedSubcategoryId = null;
                            });
                          }
                        },
                      ),
                      if (_selectedCategoryId != null)
                      CustomDropdownContainer(
                        label: "Alt Kategori : ",
                        width: 0.25,
                        value: _selectedSubcategoryId,
                        items: categories.firstWhere((category) => category.id == _selectedCategoryId).subCategories,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedItemSubCategory = value!;
                          });
                        },
                      ),
                      * */