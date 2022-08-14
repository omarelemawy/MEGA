import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/screens/auth/register/cubit_register/register_state.dart';

import '../../../../constants/utils.dart';
import '../../../../sharedPreferences.dart';
import '../../../home/home_screen.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  void registerWithEmail(name,phone,country,email,password,lang,context,myGender)
  async {
    emit(LoadingRegisterState());
    print(lang);
    print(Utils.REGISTER_URL);
    print(email);
    print(password);

    var response = await Dio().post(
        Utils.REGISTER_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
    }), data: {"name":name,
          "email":email,
          "phone":phone,
          "country":country,
          "password":password,
          /*"gender":myGender*/
        }
    );
    if(response.data["status"]=="success"){
      MySharedPreferences.saveUserId(response.data["data"]["id"].toString());
      MySharedPreferences.saveUserUserName(response.data["data"]["name"]);
      MySharedPreferences.saveUserUserEmail(response.data["data"]["email"]);
      MySharedPreferences.saveUserUserPhoneNumber(response.data["data"]["phone"]);
      MySharedPreferences.saveUserImageUrl(response.data["data"]["photo"]);
      MySharedPreferences.saveUserCountryName(response.data["data"]["country"]["name"]);
      MySharedPreferences.saveCountryCode(response.data["data"]["country"]["phone_code"]);
      print(response.data);
      String email=await MySharedPreferences().getUserUserEmail();
      emit(SuccessRegisterState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context)=>HomeScreen(Localizations.localeOf(context).languageCode,0
            ,email: email,)), (route) => false);
    }else{
      print(response.data);
      emit(ErrorRegisterState(
          response.data["message"],
        errorEmail: response.data["data"]["email"]==null?"":
        response.data["data"]["email"][0],
        errorPass: response.data["data"]["password"]==null?"":
        response.data["data"]["password"][0],
        errorPhone:response.data["data"]["phone"]==null?"":
        response.data["data"]["phone"][0]
      ));
    }
  }
}
