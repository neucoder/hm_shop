import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hm_shop/contants/index.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    // 在Web平台上，sendTimeout与没有请求体的GET请求不兼容
    if (!kIsWeb) {
      _dio.options.sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    }
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 打印响应数据
          print("响应数据:");
          print(response);
          print("=" * 80);
          // http状态码200-300 之间的状态码，会执行这里
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response);
          }

          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
            ),
          );
        },
        onError: (e, handler) {
          // 打印错误信息
          print("请求错误:");
          print(e.toString());
          print("=" * 80);
          handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    // 打印请求参数
    print("请求参数:");
    print(params);
    print("=" * 80);
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      print("响应数据:");
      print(res.data);
      print("=" * 80);

      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        return data['result'];
      }

      throw DioException(
        requestOptions: res.requestOptions,
        response: res,
        type: DioExceptionType.badResponse,
        message: data['message'] ?? '请求失败',
      );
    } on DioException catch (e) {
      print("Dio错误: ${e.message}");
      print("=" * 80);
      rethrow;
    } catch (e) {
      print("未知错误: $e");
      print("=" * 80);
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        message: '未知错误: $e',
      );
    }
  }
}
