import 'package:dio/dio.dart';

class Api {
  static Dio dio = Dio();

  static const String baseUrl = 'http://10.0.2.2:5058/api/v2';
  static String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImRvbmR1cm1haWxrbnVyMDAxQGdtYWlsLmNvbSIsImp0aSI6IjQ1MWQxZmFjLTA1NjItNDlhNi1hNDk0LWIxMjYyNmM0Y2JlMyIsImRhdGUiOiIxNS4wMy4yMDI0IDEwOjQ1OjE1IiwiaWQiOiIxMiIsInVzZXJ0eXBlIjoiS2lyYWPEsSIsIm5hbWUiOiLEsExLTlVSIiwic3VybmFtZSI6IkRPTkRVUk1BIiwiY2l0eSI6IktvbnlhIiwiZGlzdHJpY3QiOiJTZWzDp3VrbHUiLCJleHAiOjE3MTA1ODU5MTUsImlzcyI6ImF1dGhzZXJ2ZXIiLCJhdWQiOiJvcmRlcmFwaSJ9.j-hWBwaZh-Y2L0svrYVnDFogsnKPiD4Bw1LNj7meglo";
  static Options options = Options(
      headers: {
        'Authorization': 'Bearer $token', // Header'a token ekleniyor
      },
  );
  static Options optionsAuth = Options(
    contentType: 'multipart/form-data',
  );

  static login(formData) => dio.post('$baseUrl/User/login/', data: formData,options: options);

  static getAllProducts(userId) => dio.get('$baseUrl/Product/get-all/$userId');
  static getProductsByCategoryId(catId) => dio.get('$baseUrl/Product/get-category/$catId');
  static getProductsByBrandId(brId) => dio.get('$baseUrl/Product/get-brand/$brId');
  static getProductsById(pid,uid) => dio.get('$baseUrl/Product/get/$pid/$uid');
  /*
  static   addProduct => '$baseUrl/Product/add';
  static   updateProduct => '$baseUrl/Product';
  static   deleteProduct => '$baseUrl/Product/:id';
  static   getProductsBySearch => '$baseUrl/Product/category/:name';

  static const String signUp = '$baseUrl/User/sign-up';
  static const String updateUser = '$baseUrl/User/update/:id';


  static const String getCategories = '$baseUrl/Category/get-categories';

  static const String getAllBrand = '$baseUrl/Brand/get-all';
  static const String getBrandByCategory = '$baseUrl/Brand/get/:cid';

  static const String getCommentById = '$baseUrl/Comment/get/:pid';

  static const String getFavoritesByUserId = '$baseUrl/Product/get-favori/:uid';
  static const String addFavorite = '$baseUrl/Favorite/add';
  static const String deleteFavorite = '$baseUrl/Favorite/delete/pid';

  static const String getRentalsByUserId = '$baseUrl/Rental/get-by-user-id/:uid';
  static const String getRentalsByProductId = '$baseUrl/Rental/get-by-product-id/:pid';
  static const String addRental = '$baseUrl/Rental/add';

  */

}