import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    Dio dio = Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      var data = response.data;

      return data;
    } else {
      print(response.statusCode);
    }
  }
}
