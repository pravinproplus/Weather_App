import 'package:dio/dio.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        Map data = response.data;
        return data;
      }
    } catch (e) {
      print(e);
    }
  }
}
