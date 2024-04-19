import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:mario_app/Data/api/api_constants.dart';
import 'package:mario_app/Data/model/CentersResponseDto.dart';
import 'package:mario_app/Data/model/GradeResponseDto.dart';
import 'package:mario_app/Data/model/RegisterResponseDto.dart';
import 'package:mario_app/Data/model/VerifyResponseDto.dart';
import 'package:mario_app/Data/model/request/RegsiterRequestDto.dart';
import 'package:mario_app/Data/model/request/VerifyRequestDto.dart';
import 'package:mario_app/Domain/entities/failure.dart';
import 'package:http/http.dart' as http;
class ApiService{
  Future<Either<Failures,GradeResponseDto>>getGrades() async{
    var connectivityResult = await Connectivity().checkConnectivity(); // User defined class
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)){
      Uri url = Uri.http(ApiConstants.baseUrl, ApiConstants.grades);

      var response =await http.get(url);
      var gradeResponse= GradeResponseDto.fromJson(jsonDecode(response.body));
      if(response.statusCode>=200 && response.statusCode <300 ){
        return Right(gradeResponse);
      }else{
        return Left(ServerFailure(errMsg: 'not found '));
      }
    } else{
      return Left(NetworkFailure(errMsg: 'Check Your Internet Connection'));
    }
  }
  Future<Either<Failures,CentersResponseDto>>getCenters() async{
    var connectivityResult = await Connectivity().checkConnectivity(); // User defined class
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)){
      Uri url = Uri.http(ApiConstants.baseUrl, ApiConstants.centers);

      var response =await http.get(url);
      var centerResponse= CentersResponseDto.fromJson(jsonDecode(response.body));
      if(response.statusCode>=200 && response.statusCode <300 ){
        return Right(centerResponse);
      }else{
        return Left(ServerFailure(errMsg: 'not found '));
      }
    } else{
      return Left(NetworkFailure(errMsg: 'Check Your Internet Connection'));
    }
  }
  Future<Either<Failures,RegisterResponseDto>>register(String name,String email,String password ,String phone , String parentPhone,String gradeID,String centerID) async{
    var connectivityResult = await Connectivity().checkConnectivity(); // User defined class
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)){
      Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.register);
      var registerRequest=RegisterRequestDto(name: name,email: email,password: password,phone: phone,parentPhone: parentPhone,centerId: centerID,gradeId: gradeID);
      print(registerRequest.toJson().toString());
      var response =await http.post(url,body: registerRequest.toJson());
      var registerResponse= RegisterResponseDto.fromJson(jsonDecode(response.body));
      // print(registerResponse.toString());
      // print('=========');
      // print(response.body);
      if(response.statusCode>=200 && response.statusCode <300 ){
        print('okkkk');
       // return Right(registerResponse);

        return Right(registerResponse);
      }else{
       print('eroooooor');
       print(response.body.toString());
       print(response.statusCode);
        return Left(ServerFailure(errMsg: response.toString()));
      }
    } else{
      return Left(NetworkFailure(errMsg: 'Check Your Internet Connection'));
    }
  }
  Future<Either<Failures,VerifyResponseDto>>verify(String email,String code) async{
    var connectivityResult = await Connectivity().checkConnectivity(); // User defined class
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)){
      Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.verify);
      var verifyRequest=VerifyRequestDto(email: email,code: code);
     // print(registerRequest.toJson().toString());
      var response =await http.post(url,body: verifyRequest.toJson());
      var verifyResponse= VerifyResponseDto.fromJson(jsonDecode(response.body));
      // print(registerResponse.toString());
      // print('=========');
      // print(response.body);
      if(response.statusCode>=200 && response.statusCode <300 ){
        print('okkkk');
        // return Right(registerResponse);

        return Right(verifyResponse);
      }else{
        print('eroooooor');
        print(response.body.toString());
        print(response.statusCode);
        return Left(ServerFailure(errMsg: verifyResponse.message!));
      }
    } else{
      return Left(NetworkFailure(errMsg: 'Check Your Internet Connection'));
    }
  }
}