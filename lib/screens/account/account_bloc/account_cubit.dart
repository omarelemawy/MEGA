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
import '../../../models/profile_data.dart';
import '../../../models/user_data.dart';
import '../../../sharedPreferences.dart';
import '../../auth/login/login_screen.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(InitialAccountState());
  static AccountCubit get(context)=>BlocProvider.of(context);

  void changeLanguage(Language language,context) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
    MySharedPreferences.saveAppLang(_locale.toString());
    UserDateModel.appLang = await MySharedPreferences.getAppLang();
    emit(ChangeLanguageAccountState());
    var email=await MySharedPreferences().getUserUserEmail();
    pushNewScreen(
      context,
      screen: HomeScreen(language.languageCode,0,
        email: email==null?"":email,),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  ProfileData? profileData;


  Future<ProfileData?> getProfileData
      (lang,userId)async{
    print(lang);
    emit(GetProfileLoadingAccountState());
    var response = await Dio().get(
        Utils.GETMYPROFILE_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    },)
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(GetProfileSuccessAccountState());
      return ProfileData.fromJson(response.data);
    }else{
      emit(GetProfileErrorAccountState(response.data["message"]));
    }
  }
  void getProfile(lang){
    MySharedPreferences().getUserId().then((value) {
      getProfileData(lang,value).then((value) {
        profileData = value!;
      });
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
        userData = {
          "password": pass
        };
      }

      var response = await Dio().post(
          Utils.UPDATEMYPROFILE_URL, options:
      Options(headers: {
        "lang": lang,
        "Accept-Language": lang,
        "user": userId
      },),
          data: userData
      );
      print(response.data);
      if (response.data["status"] == "success") {
        Fluttertoast.showToast(
            msg: getTranslated(context, "Update Data Success")!,
            backgroundColor: customColor);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => ProfileScreen(lang)),
                (route) => false);
      } else {
        emit(UpdateProfileErrorAccountState(response.data["message"]));
      }
    }
  }

  void deleteMyProfile(context,lang,userId,context1)async{
    emit(DeleteProfileLoadingAccountState());
    var response = await Dio().post(
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
      emit(DeleteProfileSuccessAccountState());
      MySharedPreferences.saveUserId("");
      MySharedPreferences.saveUserUserName("");
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
    }else
      {
      emit(DeleteProfileErrorAccountState(response.data["message"]));
    }
  }

}