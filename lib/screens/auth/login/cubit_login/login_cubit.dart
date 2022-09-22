import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/screens/auth/forget_pass/reset_pass.dart';
import 'package:gnon/screens/auth/login/cubit_login/login_state.dart';
import 'package:gnon/screens/auth/login/login_screen.dart';
import 'package:gnon/screens/home/home_screen.dart';
import '../../../../constants/utils.dart';
import '../../../../sharedPreferences.dart';
import 'package:http/http.dart' as http;



class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  void loginWithEmail(email,password,lang,context)
  async{
    emit(LoadingLoginState());
    var response = await http.post(
        Uri.parse(Utils.LOGIN_URL+"?username=$email&password=$password"),
      body: {"email":email,
          "password":password}
    );
    print(json.decode(response.body));
    if(response.statusCode==200){

      MySharedPreferences.saveSharedGetToken(json.decode(response.body)["token"]);
      getUserData(json.decode(response.body)
      ["token"],context,lang,email,json.decode(response.body)
      ["user_nicename"]);

    }else{

      emit(ErrorLoginState(json.decode(response.body)["message"]));
    }
  }

  void getUserData(token,context,lang,email,username)
  async{

    var response = await Dio().post(
        Utils.GetData_URL,options:
        Options(headers: {
        "authorization":"Bearer ${token}",
    })
    );
    if(response.statusCode==200){
      MySharedPreferences.saveUserId(response.data["id"].toString());
      MySharedPreferences.saveUserUserName(username);
      MySharedPreferences.saveName(response.data["username"]);
      MySharedPreferences.saveUserUserEmail(email);
      MySharedPreferences.saveUserImageUrl(response.data["avatar_urls"]["96"]);
      print(response.data["username"]);
      emit(SuccessLoginState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context)=>HomeScreen(lang,email: email,)), (route) => false);
     /* getUserMoreData
        (token,context,lang,response.data["username"],pass,response.data["id"]);*/

    }else{
      emit(ErrorLoginState(response.data["message"]));
    }
  }


  /*  void getUserMoreData(token,context,lang,userName,pass,id)
  async{
    var response = await Dio().post(
        Utils.GetMOreData_URL+
        "?u=$userName&p=$pass&id=$id",options:
        Options(headers: {
        "authorization":"Bearer ${token}",
    })
    );
    if(response.statusCode==200){
      MySharedPreferences.saveUserId(response.data["id"].toString());
      MySharedPreferences.saveUserUserName(response.data["username"]);
      MySharedPreferences.saveUserUserEmail(response.data["email"]);
      */
  /*MySharedPreferences.saveUserUserPhoneNumber(response.data["data"]["phone"]);*/
  /*
      MySharedPreferences.saveUserImageUrl(response.data["avatar_urls"]["96"]);
      print(response.data["username"]);

    }else{
      emit(ErrorLoginState(response.data["message"]));
    }
  }*/



  void forgetPass(email,lang,context) async
  {
    emit(ForgetPassLoadingLoginState());
    var response = await Dio().get(
        Utils.Forgot_Pass_URL+email
    );
    print(json.decode(response.data)["msg"]);
    if(json.decode(response.data)["code"]== "200"){
      emit(ForgetPassSuccessLoginState());
      Fluttertoast.showToast(
          msg: json.decode(response.data)["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context)=>LoginScreen()), (route) => false);
    }else{
      emit(ForgetPassErrorLoginState(json.decode(response.data)["msg"]));
    }
  }

 /* void resetPass(lang,context,pin,password,password_confirmation,email) async
  {
    emit(ResetPassLoadingLoginState());
    var response = await Dio().post(
        Utils.Forgot_Pass_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
    }),
        data: {
          "pin":pin,
          "password":password,
          "password_confirmation":password_confirmation,
          "email":email
        }
    );
    print(response.data);
    if(response.data["status"]=="success"){

      emit(ResetPassSuccessLoginState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context)=>LoginScreen()), (route) => false);
    }else{
      emit(ResetPassErrorLoginState(response.data["message"]));
    }
  }*/
}
