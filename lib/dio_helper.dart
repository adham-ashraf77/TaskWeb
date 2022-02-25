import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;
  static String lang = "ar-Sa";
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.spacexdata.com/v5/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    String url,
    bool isToken,
    Map<String, dynamic> query,
  }) async {
    print(query);

    dio.options.headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      // 'Authorization': "Bearer " + LocalStorage.getData(key: "TokenUserLoad"),
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    String endPoint,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    bool isToken,
  }) async {
    dio.options.headers = {
      'Language': lang,
      'Accept-Language': lang,
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'multipart/form-data',
      "Accept": "application/json",
    };
    print(data);

    return dio.post(
      endPoint,
      queryParameters: query,
      data: FormData.fromMap(data),
    );
  }

  static Future<Response> DeleteData({
    String endPoint,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    bool isToken,
  }) async {
    dio.options.headers = {
      'Language': lang,
      'Accept-Language': lang,
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'multipart/form-data',
      "Accept": "application/json",
    };
    return dio.delete(
      endPoint,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
  }) async {
    print(data);
    dio.options.headers = {
      'Language': lang,
      'Accept-Language': lang,
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
    );
  }

  static Future<Response> patchData({
    String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
  }) async {
    print(data);
    dio.options.headers = {
      'Language': lang,
      'Accept-Language': lang,
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };

    return dio.patch(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
    );
  }
}
