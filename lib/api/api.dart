import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
final  box = GetStorage();

class Api {
  static Dio dio = Dio();

  static const String baseUrl = 'http://10.0.2.2:5058/api/v2';
  static String token=box.read('user')['token'].toString();

  static Options optionsAuth = Options(
      headers: {
        'Authorization': 'Bearer $token', // Header'a token ekleniyor
      },
  );
  static Options optionsFormData = Options(
    contentType: 'multipart/form-data',
  );
  static Options optionsAppJson = Options(
    headers: {
      'Authorization': 'Bearer $token', // Header'a token ekleniyor
    },
    contentType: 'application/json',
  );

  static login(formData) => dio.post('$baseUrl/User/login/', data: formData);
  //static const String signUp = '$baseUrl/User/sign-up';
  //static const String updateUser = '$baseUrl/User/update/:id';

  static getAllProducts(userId) => dio.get('$baseUrl/Product/get-all/$userId');
  static getHighlights(userId) => dio.get('$baseUrl/Product/get-highlights/$userId');
  static getProductsByCategoryId(catId) => dio.get('$baseUrl/Product/get-category/$catId');
  static getProductsByBrandId(brId) => dio.get('$baseUrl/Product/get-brand/$brId');
  static getProductsById(pid,uid) => dio.get('$baseUrl/Product/get/$pid/$uid');
  //static   addProduct => '$baseUrl/Product/add';
  //static   updateProduct => '$baseUrl/Product';
  //static   deleteProduct => '$baseUrl/Product/:id';
  //static   getProductsBySearch => '$baseUrl/Product/category/:name';


  static getCategories() => dio.get('$baseUrl/Category/get-categories');

  static getAllBrand() => dio.get('$baseUrl/Brand/get-all');
  static getBrandByCategoryId(cid) => dio.get('$baseUrl/Brand/get/$cid');

  static getCommentById(pid) => dio.get('$baseUrl/Comment/get/$pid');

  static getAllFavorites(uid) => dio.get('$baseUrl/Product/get-favori/$uid',options: optionsAuth);
  static addFavorite(jsonData) => dio.post('$baseUrl/Favorite/add',data:jsonData , options: optionsAppJson);
  static deleteFavorite(uid,pid) => dio.delete('$baseUrl/Favorite/delete/$uid/$pid' ,options: optionsAuth );

  //static const String getRentalsByUserId = '$baseUrl/Rental/get-by-user-id/:uid';
  //static const String getRentalsByProductId = '$baseUrl/Rental/get-by-product-id/:pid';
  //static const String addRental = '$baseUrl/Rental/add';



}