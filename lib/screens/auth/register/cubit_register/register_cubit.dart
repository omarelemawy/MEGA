import 'dart:convert';

import  'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/screens/auth/register/cubit_register/register_state.dart';
import '../../../../constants/utils.dart';
import '../../../../sharedPreferences.dart';
import '../../../home/home_screen.dart';
import 'package:http/http.dart' as http;


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  void registerWithEmail(name,phone,country,email,password,lang,context,myGender,token)
  async {
    emit(LoadingRegisterState());
    print(lang);
    print(Utils.REGISTER_URL);
    print(token);
    print(password);

    var response = await http.post(
       Uri.parse(Utils.REGISTER_URL),headers: {
      "authorization":"Bearer ${token}",
    }, body: {
          "username":name,
          "email":email,
          "billing_phone":phone,
          "password":password,
          /*"gender":myGender*/
        }
    );
    print(response.body);
    if(response.statusCode==201){
      loginWithEmail(email,password,lang,context);

    }else{
      emit(ErrorRegisterState(
          json.decode(response.body)["message"])
        /*errorEmail: response.data["data"]["email"]==null?"":
        response.data["data"]["email"][0],
        errorPass: response.data["data"]["password"]==null?"":
        response.data["data"]["password"][0],
        errorPhone:response.data["data"]["phone"]==null?"":
        response.data["data"]["phone"][0]*/
      );
    }
  }


  void getToken(name,phone,country,email,password,lang,context,myGender)
  async {

    var response = await Dio().post(
        Utils.GetToken_URL+"?username=wesam&password=mCJz)tV0FOZ2%jM8%26^E!tWvT");

    if(response.statusCode==200){

      registerWithEmail
        (name,phone,country,email,
          password,lang,context,myGender,response.data["token"]);
    }else{
      print(response.data);
    }
  }


  void loginWithEmail(email,password,lang,context)
  async{
    var response = await Dio().post(
        Utils.LOGIN_URL+"?username=$email&password=$password",
        data: {"email":email,
          "password":password}
    );
    if(response.statusCode==200){
      MySharedPreferences.saveSharedGetToken(response.data["token"]);

      getUserData(response.data["token"],context,lang,email,response.data["user_nicename"]);

    }else{
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
    print("svsivsv");
    if(response.statusCode==200){
      MySharedPreferences.saveUserId(response.data["id"].toString());
      MySharedPreferences.saveUserUserName(username);
      MySharedPreferences.saveName(response.data["username"]);
      MySharedPreferences.saveUserUserEmail(email);
      MySharedPreferences.saveUserImageUrl(response.data["avatar_urls"]["96"]);
      print(response.data["username"]);

      emit(SuccessRegisterState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context)=>HomeScreen(0,email: email,)), (route) => false);
    }else{

      Fluttertoast.showToast(msg: response.data["message"],);
     /* emit(ErrorRegisterState(
        response.data["message"],
        */
      /*errorEmail: response.data["data"]["email"]==null?"":
        response.data["data"]["email"][0],
        errorPass: response.data["data"]["password"]==null?"":
        response.data["data"]["password"][0],
        errorPhone:response.data["data"]["phone"]==null?"":
        response.data["data"]["phone"][0]*//*
      ));*/
    }
  }


}
