import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/refresh_token_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class DioClient {
  static final DioClient _instance = DioClient._init();
  static DioClient get instance => _instance;

  static BaseOptions options = BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
  );
  final Dio _dio = Dio(options);

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
// <<<<<<< HEAD
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          FirebaseCrashlytics.instance.recordError(
            e.response!.data.toString() + uri,
            StackTrace.current,
            fatal: false,
          );
        }
      }
      return throw e;
    }
// =======
//     try{
// final Response response = await _dio.post(
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );

//     return response.data;
//     }catch(e){
//       
//      return  throw e;
//     }
    
// >>>>>>> 2551e6c9364714a2f2dad64b30df05d3a065cc37
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          FirebaseCrashlytics.instance.recordError(
            e.response!.data.toString() + uri,
            StackTrace.current,
            fatal: false,
          );
        }
      }
      return throw e;
    }
  }

  Future<dynamic> get(
    String uri, {
    Headers? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          FirebaseCrashlytics.instance.recordError(
            e.response!.data.toString() + uri,
            StackTrace.current,
            fatal: false,
          );
        }
      } else {
        FirebaseCrashlytics.instance.recordError(
          "URL: $uri" + "Error: $e",
          StackTrace.current,
          fatal: false,
        );
      }
      return throw e;
    }
  }

  DioClient._init();
}
