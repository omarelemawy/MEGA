/*
class UserDate {
  final String? userName;
  final String? userEmail;
  final String? userImage;
  final String? userPhoneNamber;

  UserDate(
      {  this.userName,   this.userEmail,
        this.userImage,   this.userPhoneNamber});
}

UserDate userDate = UserDate(
  userName: 'A.Kahraba',
  userImage: 'lib/images/user.jpg',
  userEmail: 'AhmedIbrahim1310@ilcoud.com',
  userPhoneNamber: '0155105150',
);

class UserApp {
  static String? userToken;
  static String? userName;
  static String? userEmail;

  static String? userPhoneNum;
  static String? userAge;
  static String? userStutes;
  static String? userGender;
  static String? userPassword;
  static var appLang;
  static var apiLang;
  static String? userlat;
  static String? userlong;
  static String? prefs;
  static bool? userLogIn;
  static bool? userSkipLogIn;
  static bool? onBoarding;
}
*/


import '../sharedPreferences.dart';

class UserDateModel {
  String? id;
  static var appLang;
  String? name;
  String? userName;
  String? email;
  String? language;
  String? gender;
  String? phone;
  String? photo;
  String? countryCode;

  UserDateModel(
      {this.id,
        this.name,
        this.userName,
        this.email,
        this.language,
        this.gender,
        this.phone,
        this.photo,
        this.countryCode,
       });

  UserDateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name']?? "";
    userName = json['userName']?? "";
    email = json['email']?? "";
    language = json['language'];
    gender = json['gender']?? "";
    phone = json['phone']?? "";
    photo = json['photo']?? "";
    countryCode = json['countryCode']?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['language'] = this.language;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    return data;
  }
}


Future<UserDateModel> getUserDate()async{
   String? name = await MySharedPreferences.getUserUserName();
   String? id = await MySharedPreferences().getUserId();
   String? email = await MySharedPreferences().getUserUserEmail();
   String? phone = await MySharedPreferences.getUserUserPhoneNumber();
   String? photo = await MySharedPreferences.getuserImageUrl();
   String? countryName = await MySharedPreferences.getUserCountryName();
   String? countryCode = await MySharedPreferences.getCountryCode();
   print(name);
 return UserDateModel(
   id: id,name: name,email: email,phone: phone,photo: photo,
     countryCode:countryCode
 );
}
