import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/screens/auth/forget_pass/reset_pass.dart';
import 'package:gnon/screens/auth/login/cubit_login/login_state.dart';
import 'package:gnon/screens/auth/login/login_screen.dart';
import 'package:gnon/screens/home/home_screen.dart';
import '../../../../constants/utils.dart';
import '../../../../sharedPreferences.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  void loginWithEmail(email,password,lang,context)
  async{
    emit(LoadingLoginState());

    var response = await Dio().post(
        Utils.LOGIN_URL,options:
    Options(headers: {
          "lang":lang,
          "Accept-Language":lang,
    }),
      data: {"email":email,
          "password":password}
    );
    if(response.data["status"]=="success"){
      MySharedPreferences.saveUserId(response.data["data"]["id"].toString());
      MySharedPreferences.saveUserUserName(response.data["data"]["name"]);
      MySharedPreferences.saveUserUserEmail(response.data["data"]["email"]);
      MySharedPreferences.saveUserUserPhoneNumber(response.data["data"]["phone"]);
      MySharedPreferences.saveUserImageUrl(response.data["data"]["photo"]);
      MySharedPreferences.saveUserCountryName(response.data["data"]["country"]["name"]);
      MySharedPreferences.saveCountryCode(response.data["data"]["country"]["phone_code"]);

      String email=await MySharedPreferences().getUserUserEmail();

      emit(SuccessLoginState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: 
          (context)=>HomeScreen(lang,0,email: email,)), (route) => false);
    }else{
      emit(ErrorLoginState(response.data["message"]));
    }
  }

  void forgetPass(email,lang,context) async
  {
    emit(ForgetPassLoadingLoginState());
    var response = await Dio().post(
        Utils.Forgot_Pass_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
    }),
        data: {"email":email}
    );
    if(response.data["status"]=="success"){
      emit(ForgetPassSuccessLoginState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context)=>ResetPassScreen(email: email,)), (route) => false);
    }else{
      emit(ForgetPassErrorLoginState(response.data["message"]));
    }
  }
  void resetPass(lang,context,pin,password,password_confirmation,email) async
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
  }
}
