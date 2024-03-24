import 'package:dio/dio.dart';

class Fetcher {
  final Function(Map<String, dynamic>) fromJsonFunction;
  final Future<Response<dynamic>> Function() APIEndpoint;
  final Function(List<dynamic>) setData;
  bool isLoading = false;

  Fetcher(this.fromJsonFunction, this.setData, this.APIEndpoint);

  Future<void> fetchData() async {
    try {
      isLoading = true;
      Response response = await APIEndpoint(); // Await the function call here
      print(response.data);
      if (response.statusCode == 200) {
        dynamic responseData = response.data['data'];
        if (responseData != null) {
          if (responseData is Map<String, dynamic>) {
            // Single data returned
            isLoading = false;
            setData([fromJsonFunction(responseData)]);
          } else if (responseData is List<dynamic>) {
            // Multiple data returned
            isLoading = false;
            setData(responseData.map((data) => fromJsonFunction(data)).toList());
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}



