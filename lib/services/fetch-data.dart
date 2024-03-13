import 'package:dio/dio.dart';

class Fetcher {
  final String apiUrl;
  final Function(Map<String, dynamic>) fromJsonFunction;
  final Function(List<dynamic>) setData;

  Fetcher(this.apiUrl, this.fromJsonFunction, this.setData);

  Future<void> fetchData() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(apiUrl);
      print(response.data);
      if (response.statusCode == 200) {
        dynamic responseData = response.data['data'];
        if (responseData != null) {
          if (responseData is Map<String, dynamic>) {
            // Tek bir veri döndü
            setData([fromJsonFunction(responseData)]);
          } else if (responseData is List<dynamic>) {
            // Birden fazla veri döndü
            setData(responseData.map((data) => fromJsonFunction(data)).toList());
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
