import 'package:ap_03_luongquocdien/main.dart';
import 'package:ap_03_luongquocdien/network/response/login/response_login.dart';
import 'package:ap_03_luongquocdien/network/response/template/response_template.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthService {
  factory AuthService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        headers: {
          'Content-Type':'application/json'
        }
    );
    return _AuthService(dio,baseUrl:baseUrl);
  }

  @POST("/regist")
  Future<ResponseTemplate> registAccount(@Body() Map<String,dynamic> body);

  @POST("/login")
  Future<ResponseLogin> login(@Body() Map<String,dynamic> body);

}