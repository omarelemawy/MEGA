
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/models/cart_data_model.dart';
import 'package:gnon/screens/home/home_screen.dart';
import 'package:gnon/sharedPreferences.dart';
import '../../../constants/utils.dart';
import '../../../models/address_model.dart';
import '../../../models/countries_model.dart';
import 'package:http/http.dart' as http;
import '../ship_to_screen.dart';
part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  static AddressCubit get(context) => BlocProvider.of(context);

  CountriesModel? countriesModel;
  List<ItemsOfCart>? cartDataModel = [];
  List<Address>? addressList = [];
  CountriesModel? governoratesModel;
  CountriesModel? cityModel;
  CartDataModel? cartModel;

  Future<CountriesModel?> getCountries
      (lang) async {
    emit(GetLoadingAddressState());

    var response = await Dio().get(
      Utils.CategoryCountries_URL, options:
    Options(headers: {
      "lang": lang,
      "value": "id",
    }),
    );
    if (response.data["status"] == "success") {
      emit(GetSuccessAddressState());
      return CountriesModel.fromJson(response.data);
    } else {
      emit(GetErrorAddressState(response.data["message"]));
    }
  }

  void getAddressData(lang) {
    getCountries(lang).then((value) {
      countriesModel = value!;
    });
  }


  void getGovernorates
      (lang, id) async {
    emit(GetLoadingGovernoratesAddressState());
    var response = await Dio().get(
      "${Utils.CategoryCountries_URL}/$id/governorates", options:
    Options(headers: {
      "lang": lang,
      "value": "id",
    }),
    );
    if (response.data["status"] == "success") {
      governoratesModel = CountriesModel.fromJson(response.data);
      print(response.data);
      emit(GetSuccessGovernoratesAddressState());
    }
  }


  void getCity
      (lang, governoratesid, id) async {
    emit(GetLoadingCityAddressState());
    var response = await Dio().get(
      "${Utils.CategoryCountries_URL}/$governoratesid/governorates/$id/cities",
      options:
      Options(headers: {
        "lang": lang,
        "value": "id",
      }),
    );
    if (response.data["status"] == "success") {
      cityModel = CountriesModel.fromJson(response.data);
      print(response.data);
      emit(GetSuccessCityAddressState());
    }
  }


  Future submitCheckOut
      (token,
      firstName,
      lastName,
      email,
      address,
      city,
      state,
      phone,
      context) async {
    emit(GetLoadingSubmitCheckOutState());
    print(token);
    var response = await Dio().post(
        Utils.SubmitCheckOut_URL+'?'+Utils.BASEData_URL,
        options: Options(headers: {
          "authorization":"Bearer ${token}",
          "X-WC-Store-API-Nonce": "wc_store_api",
          "Content-Type": "application/json",
        }),
        data:/*{
          "billing_address": {
            "first_name": "Steve",
            "last_name": "Stevenson",
            "email": "test@test.com",
            "address_1": "41 Some Street",
            "city": "Townford",
            "state": "جدة",
            "postcode": "CB25 6FG",
            "country": "sa"
          },
          "shipping_address": {
            "first_name": "Steve",
            "last_name": "Stevenson",
            "address_1": "41 Some Street",
            "city": "Townford",
            "state": "جدة",
            "postcode": "CB25 6FG",
            "country": "sa"
          },
          "payment_method": "cod"
        }*/
        {
          "billing_address": {
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone": phone,
            "address_1": address,
            "city": city,
            "state": state,
            "postcode": "CB25 6FG",
            "country": "sa"
          },
          "shipping_address": {
            "first_name": firstName,
            "last_name": lastName,
            "address_1": address,
            "phone": phone,
            "city": city,
            "state": state,
            "postcode": "CB25 6FG",
            "country": "sa"
          },
          "payment_method": "cod"
        }
    );
    if (response.statusCode==200||response.statusCode==201) {
      print(response.data);
      emit(GetSuccessSubmitCheckOutState());
      Fluttertoast.showToast(
          msg: "شكرا لك , تم استلام طلبك",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      MySharedPreferences().getUserUserEmail().then((value) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) =>
            HomeScreen(
              0,email:
              value,
            )), (route) => false);
      });

    } else {
      print(response.data);
      emit(GetErrorSubmitCheckOutState(response.data["message"]));
    }
  }

/*  void updateAddress
      (userId,
      country,
      governorate,
      city,
      address,
      postalCode,
      phone,
      context,
      withFloatingActionButton,
      id) async {
    emit(GetLoadingCreateAddressState());
    var response = await Dio().post(
        "${Utils.UpdateAddress_URL}$id /update",
        options: Options(headers: {
          "lang": Localizations
              .localeOf(context)
              .languageCode,
          "Accept-Language": Localizations
              .localeOf(context)
              .languageCode,
          "user": userId,
        }),
        data: {
          "country": country,
          "governorate": governorate,
          "city": city,
          "address": address,
          "postal_code": postalCode,
          "phone": phone,
        }
    );
    if (response.data["status"] == "success") {
      print(response.data);
      emit(GetSuccessCreateAddressState());
      MySharedPreferences().getUserUserEmail().then((value) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) =>
            ShipToScreen(
              Localizations
                  .localeOf(context)
                  .languageCode,
              withFloatingActionButton: withFloatingActionButton,
            )), (route) => false);
      });
    } else {
      print(response.data);
      emit(GetErrorCreateAddressState(response.data["message"]));
    }
  }*/


  Future<List<Address>?> getAddressList
      (lang, userId) async {
    emit(GetLoadingGetAddressListState());
    print(userId);
    var response = await Dio().get(
      Utils.GetAddressList_URL, options:
    Options(headers: {
      "lang": lang,
      "Accept-Language": lang,
      "user": userId
    }),
    );
    if (response.data["status"] == "success") {
      emit(GetSuccessGetAddressListState());
      return AddressModel
          .fromJson(response.data)
          .data;
    } else {
      emit(GetErrorGetAddressListState(response.data["message"]));
    }
  }

  void getMyAddress(lang) {
    MySharedPreferences().getUserId().then((value) {
      getAddressList(lang, value).then((value) {
        addressList = value!;
      });
    });
  }

  void deleteAddress
      (context, id, userId, withFloatingActionButton) async {
    emit(DeleteLoadingAddressState());
    var lang = Localizations
        .localeOf(context)
        .languageCode;

    var response = await Dio().get(
      "${Utils.DELETEADDREES_URL}$id/delete",
      options:
      Options(headers: {
        "lang": lang,
        "Accept-Encoding": lang,
        "user": userId
      }),
    );
    print(response.data);
    if (response.data["status"] == "success") {
      print("object");
      emit(DeleteSuccessAddressState());
      MySharedPreferences().getUserUserEmail().then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) =>
            ShipToScreen(
              lang, withFloatingActionButton: withFloatingActionButton
              ,)), (route) => false);
      });
    }
    print("object");
  }

  Future<List<ItemsOfCart>?> getCartDetails
      ( userId) async {
    emit(GetLoadingCartDateState());
    var response = await Dio().get(
        Utils.CartDetails_URL + "?" + Utils.BASEData_URL,
        options: Options(
            headers: {
              "X-WC-Store-API-Nonce": "wc_store_api",
              "authorization": "Bearer ${userId}"
            }
        )
    );

    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 200) {
      emit(GetSuccessCartDateState());
      cartModel = CartDataModel.fromJson(response.data);
      return CartDataModel
          .fromJson(response.data)
          .items;
    } else {
      emit(GetErrorCartDateState(response.data["message"]));
    }
  }


  bool? isLogin;

  void getCartData() {
    MySharedPreferences.getUserGetToken().then((value) {
      print(value);
      if (value == "" || value == null) {
        isLogin = false;
      } else {
        isLogin = true;
        getCartDetails(value).then((value) {
          cartDataModel = value!;
        });
      }
    });
  }


  void addQuantityItem
      (lang, userId, productId, quantity) async {
    print(productId);
    print(quantity);
    var response = await Dio().post(
        Utils.Ubdatecart_URL+"?"+Utils.BASEData_URL,
        options: Options(
          headers: {
            "X-WC-Store-API-Nonce": "wc_store_api",
            "authorization": "Bearer ${userId}"
          }
        ),
        data: {
          "key":productId,
          "quantity":quantity
        }
    );
    if(response.statusCode == 201||response.statusCode == 200){
      Fluttertoast.showToast(msg: "don");
      getCartData();
    } else {
      emit(GetErrorCartDateState(response.data["message"]));
    }
  }

  void deleteItemCart
      (lang, userId, productId) async {
    print(productId);
    var response = await http.delete(
        Uri.parse( Utils.RemoveFromCart_URL+"$productId"+ "?" + Utils.BASEData_URL)
        , headers:  {
    "X-WC-Store-API-Nonce": "wc_store_api",
    "authorization": "Bearer ${userId}"
    }
    );
    if (response.statusCode == 200 || response.statusCode == 201||response.statusCode == 204) {
      Fluttertoast.showToast(msg: "don");
      print("yguyftyfnfgnbdfbffbfgn");
      getCartData();
    } else {
      print("yguyftyfnf");
      print(response.body);
      emit(GetErrorCartDateState(json.decode(response.body)["message"]));
    }
  }



 /* void removeItemFromCart
      (lang, userId, productId) async {
    print(productId);
    var response = await http.delete(
        Uri.parse( Utils.RemoveItemFromCart_URL+"$productId"+ "?" + Utils.BASEData_URL)
        , headers:  {
    "X-WC-Store-API-Nonce": "wc_store_api",
    "authorization": "Bearer ${userId}"
    }
    );
    if (response.statusCode == 200 || response.statusCode == 201||response.statusCode == 204) {
      Fluttertoast.showToast(msg: "don");
      print("yguyftyfnfgnbdfbffbfgn");
      getCartData(lang);
    } else {
      print("yguyftyfnf");
      print(response.body);
      emit(GetErrorCartDateState(json.decode(response.body)["message"]));
    }
  }*/

  void makeLikeProduct(itemId, userId, lang) async {
    var response = await Dio().post(
      Utils.AddToFAv_URL + "$itemId/create", options:
    Options(headers: {
      "lang": lang,
      "user": userId,
      "Accept-Language": lang,
    },),
    );
    print(response.data);
    if (response.data["status"] == "success") {
      print(response.data);
      Fluttertoast.showToast(
          msg: response.data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  void makeDisLikeProduct(itemId, userId, lang) async {
    var response = await Dio().get(
      Utils.RemoveFAV_URL + "$itemId/delete", options:
    Options(headers: {
      "lang": lang,
      "user": userId,
      "Accept-Language": lang,
    },),

    );
    print(response.data);
    if (response.data["status"] == "success") {
      print(response.data);
      Fluttertoast.showToast(
          msg: response.data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  void checkCupounItemCart
      ( userId, coupon) async {
    print(userId);
    emit(GetLoadingCouponCartDateState());
    var response = await http.post(
        Uri.parse(Utils.CheckCupounCart_URL + "?" + Utils.BASEData_URL),
        headers: {
          "X-WC-Store-API-Nonce": "wc_store_api",
          "authorization": "Bearer ${userId}"
        },
        body: {
          "code": coupon,
        }
    );
    if (response.statusCode == 200 || response.statusCode == 201)
      {
      emit(GetSuccessCouponCartDateState());
      Fluttertoast.showToast(msg: "don");
      getCartData();
    }
      else
      {
      Fluttertoast.showToast(msg: json.decode(response.body)["message"],
          backgroundColor: customColor);
      emit(GetErrorCouponCartDateState(json.decode(response.body)["message"]));
    }
  }


}
