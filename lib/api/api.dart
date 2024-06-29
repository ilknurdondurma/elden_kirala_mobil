import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
final  box = GetStorage();

class Api {
  static Dio dio = Dio();

  static const String baseUrl = 'http://10.0.2.2:5058/api/v2';
  static String token=box.read("user")["token"];
  //--------token
  static Options optionsAuth = Options(
      headers: {
        'Authorization': 'Bearer $token', // Header'a token ekleniyor
      },
  );

  //--------formdata
  static Options optionsFormData = Options(
    headers: {
      'Content-Type': 'multipart/form-data', // Header'a token ekleniyor
    }
  );

  //--------application/json
  static Options optionsAppJson = Options(
    headers: {
      'Content-Type': 'application/json-patch+json', // Header'a token ekleniyor
    },
  );

  //--------application/json + token
  static Options optionsAppJsonandToken = Options(
    headers: {
      'Authorization': 'Bearer $token', // Header'a token ekleniyor
    },
    contentType: 'application/json',
  );






  static login(formData) => dio.post('$baseUrl/User/login/', data: formData);
  static signUp(formdata) => dio.post('$baseUrl/User/sign-up', data:formdata);
  static  updateUser(userId,updatedUser) => dio.put('$baseUrl/User/update/$userId',data: updatedUser);

  static getAllProducts(userId) => dio.get('$baseUrl/Product/get-all/$userId');
  static getHighlights(userId) => dio.get('$baseUrl/Product/get-highlights/$userId');
  static getHighlightsByCategory(userId,categoryId) => dio.get('$baseUrl/Product/get-highlights-category/$userId/$categoryId');
  static getHighlightsByBrand(userId ,brandId) => dio.get('$baseUrl/Product/get-highlights-brand/$userId/$brandId');

  static getProductsByCategoryId(catId) => dio.get('$baseUrl/Product/get-category/$catId');
  static getProductsByBrandId(brId) => dio.get('$baseUrl/Product/get-brand/$brId');
  static getProductsById(pid,uid) => dio.get('$baseUrl/Product/get/$pid/$uid');
  static addProduct(product) => dio.post('$baseUrl/Product/add',data:product,options: optionsFormData);
  //static   updateProduct => '$baseUrl/Product';
  //static   deleteProduct => '$baseUrl/Product/:id';
  //static   getProductsBySearch => '$baseUrl/Product/category/:name';


  static getCategories() => dio.get('$baseUrl/Category/get-categories');

  static getAllBrand() => dio.get('$baseUrl/Brand/get-all');
  static getBrandByCategoryId(cid) => dio.get('$baseUrl/Brand/get/$cid');

  static getCommentById(pid) => dio.get('$baseUrl/Comment/get-by-product/$pid');
  static getCommentByUserId(uid) => dio.get('$baseUrl/Comment/get-by-user/$uid');
  static addComment(comment) => dio.post('$baseUrl/Comment/add',data:comment ,options: optionsAuth);
  static updateComment(comment) => dio.put('$baseUrl/Comment/update',data:comment ,options: optionsAuth);
  static deleteComment(id) => dio.delete('$baseUrl/Comment/delete/$id',options: optionsAuth);

  static getAllFavorites(uid) => dio.get('$baseUrl/Product/get-favori/$uid',options: optionsAuth);
  static addFavorite(jsonData) => dio.post('$baseUrl/Favorite/add',data:jsonData , options: optionsAppJsonandToken);
  static deleteFavorite(uid,pid) => dio.delete('$baseUrl/Favorite/delete/$uid/$pid' ,options: optionsAuth );

  static getRentalsByUserId(userId) => dio.get('$baseUrl/Rental/get-by-user-id/$userId') ;
  //static const String getRentalsByProductId = '$baseUrl/Rental/get-by-product-id/:pid';
  static addRental(rental) => dio.post('$baseUrl/Rental/add',data:rental);

  static getMessagesByUserId(uid) => dio.get('$baseUrl/Message/get-by-user/$uid');
  static getMessagesUserToUser(sid,rid) => dio.get('$baseUrl/Message/get-userto-user/$sid/$rid');


}