import 'dart:convert';
import 'package:elden_kirala/models/product-model/product-model.dart';
import 'package:http/http.dart' as http;

class FetchDataFromJson {
  final String url = "http://192.168.0.16:8081/api/v2/Product/get-all/12";

  Future<List<ProductModel>> getProduct() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dynamic responseBody = json.decode(response.body);
      if (responseBody.containsKey('data')) {
        List<dynamic> dataList = responseBody['data'];
        List<ProductModel> products = dataList
            .map((dynamic item) => ProductModel.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception("Response body does not contain 'data' key");
      }
    } else {
      throw Exception("Failed to load products");
    }
  }
}

