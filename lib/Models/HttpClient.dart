import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {

  Dio dio = Dio();

  String baseURL = 'http://10.0.2.2:8000/api';

  Map<String, dynamic> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "",
  };

  HttpClient(){
    dio.options.baseUrl = baseURL;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.headers = headers;
  }

  void setToken(String token) async{
    headers["Authorization"] = "Bearer $token";
    dio.options.headers = headers;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }


  Future post(String url, Map data) async {
    try {
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      return e.response;
    }
  }

  //AuthCheck
  Future authCheck() async {
    Response response = await post('/auth/check', {});
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  //SignIn
  Future signIn(Map data) async {
    Response response = await post('/auth/login', data);
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }


}

HttpClient httpClient = HttpClient();
