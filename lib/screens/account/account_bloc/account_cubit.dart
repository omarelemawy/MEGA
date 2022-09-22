import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/main.dart';
import 'package:gnon/screens/account/profile_screen.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../constants/utils.dart';
import '../../../localization/localization_constants.dart';
import '../../../models/language.dart';
import '../../../models/replacement_policy_screen.dart';
import '../../../models/profile_data.dart';
import '../../../models/setting_model.dart';
import '../../../models/user_data.dart';
import '../../../sharedPreferences.dart';
import '../../auth/login/login_screen.dart';
import 'account_state.dart';
import 'package:http/http.dart' as http;

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(InitialAccountState());
  static AccountCubit get(context)=>BlocProvider.of(context);

  SettingsModel? settingsModel;

  void changeLanguage(Language language,context) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
    MySharedPreferences.saveAppLang(_locale.toString());
    UserDateModel.appLang = await MySharedPreferences.getAppLang();
    emit(ChangeLanguageAccountState());
    var email=await MySharedPreferences().getUserUserEmail();
    pushNewScreen(
      context,
      screen: HomeScreen(0,
        email: email==null?"":email,),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  ProfileData? profileData;
  ReplacementPolicyScreenModel? privacyModel;


  Future<ProfileData?> getProfileData
      (lang)async{
    emit(GetProfileLoadingAccountState());
    ProfileData? profileData=
    ProfileData(email: await MySharedPreferences().getUserUserEmail(),
    userName: await MySharedPreferences.getUserUserName(),
    name: await MySharedPreferences.getName(),
    image: await MySharedPreferences.getuserImageUrl() );
    emit(GetProfileSuccessAccountState());
    return profileData;

           /*   print(lang);
    emit(GetProfileLoadingAccountState());
    var response = await Dio().post(
        Utils.GetData_URL,options:
    Options(headers: {
      "authorization":"Bearer ${userId}",
    })
    );

    if(response.statusCode==200){
      emit(GetProfileSuccessAccountState());
      return ProfileData.fromJson(response.data);
    }else{
      emit(GetProfileErrorAccountState(response.data["message"]));
    }*/
  }
  void getProfile(lang){
    getProfileData(lang).then((value) {
      profileData = value!;
    });
  }

  void updateProfile(lang,userId,context,{name,gender,date,email,phone,pass,photo})
  async{
    emit(UpdateProfileLoadingAccountState());

    if(photo!=null)
    {
      String fileName = photo.path.split('/').last;
      FormData formData = FormData.fromMap({
        "photo":
        await MultipartFile.fromFile(photo.path, filename:fileName),
      });
      var response = await Dio().post(
          Utils.UPDATEMYPROFILE_URL,options:
      Options(headers: {
        "lang":lang,
        "Accept-Language":lang,
        "user":userId
      },),
          data:formData
      );
      print(response.data);
      if(response.data["status"]=="success")
      {
        Fluttertoast.showToast(
            msg: getTranslated(context, "Update Data Success")!,
            backgroundColor: customColor);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>ProfileScreen(lang)),
                (route) => false);
      }else{
        emit(UpdateProfileErrorAccountState(response.data["message"]));
      }
    }
    else {
      var userData;

      if (name != null) {
        print(name);
        userData = {
          "name": name
        };
      }



      else if (gender != null) {
        userData = {
          "gender": gender
        };
      }

      else if (date != null) {
        userData = {
          "birth_date": date
        };
      }

      else if (email != null) {
        print(email);
        userData = {
          "email": email
        };
      }

      else if (phone != null) {
        userData = {
          "phone": phone
        };
      }

      else if (pass != null) {

        print(pass);

        userData = {
          "password": pass
        };
      }

      print(userData);
      var response = await http.post(
          Uri.parse(Utils.UPDATEMYPROFILE_URL), headers: {
        "authorization":"Bearer ${userId}",
      },
          body: userData
      );
      print(response.body);
      if (response.statusCode==200||response.statusCode==201) {
        MySharedPreferences.saveUserUserName(json.decode(response.body)["username"]);
        MySharedPreferences.saveName(json.decode(response.body)["name"]);
        MySharedPreferences.saveUserUserEmail(json.decode(response.body)["email"]);

        Fluttertoast.showToast(
            msg: getTranslated(context, "Update Data Success")!,
            backgroundColor: customColor);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => ProfileScreen(lang)),
                (route) => false);
      } else {
        Fluttertoast.showToast(
            msg: json.decode(response.body)["message"],
            backgroundColor: customColor);
        emit(UpdateProfileErrorAccountState(json.decode(response.body)["message"]));
      }
    }
  }

  void deleteMyProfile(context,lang,userId,context1)async{
    emit(DeleteProfileLoadingAccountState());

    emit(DeleteProfileSuccessAccountState());
    MySharedPreferences.saveUserId("");
    MySharedPreferences.saveUserUserName("");
    MySharedPreferences.saveSharedGetToken("");
    MySharedPreferences.saveUserUserEmail("");
    MySharedPreferences.saveUserUserPhoneNumber("");
    MySharedPreferences.saveUserImageUrl("");
    MySharedPreferences.saveUserCountryName("");
    MySharedPreferences.saveCountryCode("");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()),
            (route) => false);
    Navigator.pop(context1);
    /*var response = await Dio().post(
        Utils.DeleteMYPROFILE_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    },),
    );
    print(response.data);
    if(response.data["status"]=="success")
    {

    }else
      {
      emit(DeleteProfileErrorAccountState(response.data["message"]));
    }*/
  }


  Future<ReplacementPolicyScreenModel?> getReplacementPolicyData
      (id)async{
    emit(GetReplacementPolicyLoadingAccountState());

    var response = await Dio().get(
        Utils.GetPrivacyData_URL+"/$id"+"?"+Utils.BASEData_URL
    );

    if(response.statusCode==200){
      print(response.data);
      emit(GetReplacementPolicySuccessAccountState());
      return ReplacementPolicyScreenModel.fromJson(response.data);
    }else{
      emit(GetReplacementPolicyErrorAccountState(response.data["message"]));
    }
  }

  void getPrivacy(lang){
    print("sgffesagsdgwsafawfaewfsefgswe");
    getReplacementPolicyData(lang).then((value) {
      print("sgffesagsdgwsafawfaewfsefgswe");
      privacyModel = value!;
      print("sgffesagsdgwsafawfaewfsefgswe"+privacyModel!.title!.rendered!);

    });
  }


  Future<SettingsModel?> getSettingsData
      ()async{
    emit(GetLoadingSettingsDataAccountState());
    var response = await Dio().get(
        Utils.Settings_URL
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(GetSuccessSettingsDataAccountState());

      return SettingsModel.fromJson(response.data);
    }else{
      emit(GetErrorSettingsDataAccountState(response.data["message"]));
    }
  }

  void getSettings(){
    print("jsdoifsfewsfe");
    getSettingsData().then((value) {
      settingsModel=value!;
    });
  }

}