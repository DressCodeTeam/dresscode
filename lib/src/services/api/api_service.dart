import 'package:dio/dio.dart';
import 'package:dresscode/src/constants/api.dart';
import 'package:dresscode/src/services/base.service.dart';

class ApiService extends BaseService {

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl, // Replace with your base URL
        connectTimeout: const Duration(milliseconds: 50000),
        receiveTimeout: const Duration(milliseconds: 50000),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }
  
  late Dio _dio;

  // Handle errors
  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw Exception('Connection timeout');
      case DioExceptionType.badResponse:
        throw Exception('Received invalid SC: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        throw Exception('Request to API server was cancelled');
      case DioExceptionType.unknown:
        throw Exception('Connection to API server failed: ${error.message}');
      default:
        return;
    }
  }

  // GET request
  Future<Response> get(
    String endpoint,
    {
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams
    }
  ) async {
    try {
      final response = await _dio.get(
        endpoint,
        data: data,
        queryParameters: queryParams,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String endpoint,
    {
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams
    }
  ) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(
    String endpoint,
    {
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams
    }
  ) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParams
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
    String endpoint,
    {
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams
    }
  ) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParams
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }
}
