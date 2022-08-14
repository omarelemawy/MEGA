
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/constants/color_constans.dart';
import 'package:gnon/models/cart_data_model.dart';
import 'package:gnon/sharedPreferences.dart';
import '../../../constants/utils.dart';
import '../../../models/address_model.dart';
import '../../../models/countries_model.dart';
import '../../home/home_screen.dart';
import '../ship_to_screen.dart';
part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial()) ;
  static AddressCubit get(context)=>BlocProvider.of(context);

  CountriesModel? countriesModel;
  List<ItemsCartData>? cartDataModel=[];
  List<Address>? addressList=[];
  CountriesModel? governoratesModel;
  CountriesModel? cityModel;
  CartDataModel? cartModel;

  Future<CountriesModel?> getCountries
      (lang)async{
    emit(GetLoadingAddressState());
    var response = await Dio().get(
        Utils.CategoryCountries_URL,options:
    Options(headers: {
      "lang":lang,
      "value":"id",
    }),
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessAddressState());
      return CountriesModel.fromJson(response.data);
    }else{
      emit(GetErrorAddressState(response.data["message"]));
    }
  }

  void getAddressData(lang){
    getCountries(lang).then((value) {
      countriesModel = value!;
      });
  }


  void getGovernorates
      (lang,id)async{
    emit(GetLoadingGovernoratesAddressState());
    var response = await Dio().get(
      "${Utils.CategoryCountries_URL}/$id/governorates",options:
    Options(headers: {
      "lang":lang,
      "value":"id",
    }),
    );
    if(response.data["status"]=="success")
    {
      governoratesModel=CountriesModel.fromJson(response.data);
      print(response.data);
      emit(GetSuccessGovernoratesAddressState());
    }
  }


  void getCity
      (lang,governoratesid,id)async{
    emit(GetLoadingCityAddressState());
    var response = await Dio().get(
      "${Utils.CategoryCountries_URL}/$governoratesid/governorates/$id/cities",
      options:
    Options(headers: {
      "lang":lang,
      "value":"id",
    }),
    );
    if(response.data["status"]=="success")
    {
      cityModel=CountriesModel.fromJson(response.data);
      print(response.data);
      emit(GetSuccessCityAddressState());
    }
  }




  void createAddress
      (userId,
      country,
      governorate,
      city,
      address,
      postalCode,
      phone,
      context,
      withFloatingActionButton,
      orderDate
      )
  async{
    emit(GetLoadingCreateAddressState());
    var response = await Dio().post(
      Utils.CreateAddress_URL,
      options:Options(headers: {
        "lang":Localizations.localeOf(context).languageCode,
        "Accept-Language":Localizations.localeOf(context).languageCode,
        "user":userId,
      }),
      data: {
        "country":country,
        "governorate":governorate,
        "city":city,
        "address":address,
        "postal_code":postalCode,
        "phone":phone,
      }
    );
    if(response.data["status"]=="success")
    {
      print(response.data);
      emit(GetSuccessCreateAddressState());
      MySharedPreferences().getUserUserEmail().then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
            ShipToScreen(
              Localizations.localeOf(context).languageCode,
              withFloatingActionButton: withFloatingActionButton,
              orderData: orderDate,
            )), (route) => false);
      });
    }else{
      print(response.data);
      emit(GetErrorCreateAddressState(response.data["message"]));
    }
  }
 void updateAddress
      (userId,
      country,
      governorate,
      city,
      address,
      postalCode,
      phone,
      context,
      withFloatingActionButton,
       id
      )
  async{
    emit(GetLoadingCreateAddressState());
    var response = await Dio().post(
      "${Utils.UpdateAddress_URL}$id /update",
      options:Options(headers: {
        "lang":Localizations.localeOf(context).languageCode,
        "Accept-Language":Localizations.localeOf(context).languageCode,
        "user":userId,
      }),
      data: {
        "country":country,
        "governorate":governorate,
        "city":city,
        "address":address,
        "postal_code":postalCode,
        "phone":phone,
      }
    );
    if(response.data["status"]=="success")
    {
      print(response.data);
      emit(GetSuccessCreateAddressState());
      MySharedPreferences().getUserUserEmail().then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
            ShipToScreen(
              Localizations.localeOf(context).languageCode,
              withFloatingActionButton: withFloatingActionButton,
            )), (route) => false);
      });
    }else{
      print(response.data);
      emit(GetErrorCreateAddressState(response.data["message"]));
    }
  }


  Future<List<Address>?> getAddressList
      (lang,userId)async{
    emit(GetLoadingGetAddressListState());
    print(userId);
    var response = await Dio().get(
        Utils.GetAddressList_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    }),
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessGetAddressListState());
      return AddressModel.fromJson(response.data).data;
    }else{
      emit(GetErrorGetAddressListState(response.data["message"]));
    }
  }
  void getMyAddress(lang){
    MySharedPreferences().getUserId().then((value){
      getAddressList(lang,value).then((value) {
        addressList = value!;
      });
    });
  }

  void deleteAddress
      (context,id,userId,withFloatingActionButton)async{
    emit(DeleteLoadingAddressState());
    var lang = Localizations.localeOf(context).languageCode;

    var response = await Dio().get(
      "${Utils.DELETEADDREES_URL}$id/delete",
      options:
      Options(headers: {
        "lang":lang,
        "Accept-Encoding":lang,
        "user": userId
      }),
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      print("object");
      emit(DeleteSuccessAddressState());
      MySharedPreferences().getUserUserEmail().then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) => ShipToScreen(lang,withFloatingActionButton:withFloatingActionButton
              ,)), (route) => false);
      });
    }
    print("object");
  }

  Future<List<ItemsCartData>?> getCartDetails
      (lang,userId)async{
    emit(GetLoadingCartDateState());
    var response = await Dio().get(
      Utils.CartDetails_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId,
    }),
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(GetSuccessCartDateState());
      cartModel = CartDataModel.fromJson(response.data);
      return CartDataModel.fromJson(response.data).data!.items;
    }else{
      emit(GetErrorCartDateState(response.data["message"]));
    }
  }
  bool? isLogin;
  void getCartData(lang){
    MySharedPreferences().getUserId().then((value) {
      print(value);
      if(value == ""||value == null){
        isLogin=false;
      }else {
        isLogin=true;
        getCartDetails(lang, value).then((value) {
          cartDataModel = value!;
        });
      }
    });
  }

  void changeQuantityItem
      (lang,userId,productId,quantity)async{

    var response = await Dio().post(
      Utils.ChangeQuantity_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId,
    }),
      data: {
        "product_id":productId,
        "quantity":quantity
      }
    );
    if(response.data["status"]=="success")
    {
      Fluttertoast.showToast(msg: "don");
      getCartData(lang);
    }else{
      emit(GetErrorCartDateState(response.data["message"]));
    }
  }

  void removeItemCart
      (lang,userId,productId)async{

    var response = await Dio().post(
        Utils.RemoveFromCart_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId,
    }),
        data: {
          "product_id":productId,
        }
    );
    if(response.data["status"]=="success")
    {
      Fluttertoast.showToast(msg: "don");
      getCartData(lang);
    }else{
      emit(GetErrorCartDateState(response.data["message"]));
    }
  }

  void makeLikeProduct(itemId,userId,lang)async{
    var response = await Dio().post(
      Utils.AddToFAv_URL+"$itemId/create",options:
    Options(headers: {
      "lang":lang,
      "user":userId,
      "Accept-Language":lang,
    },),
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
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

  void makeDisLikeProduct(itemId,userId,lang)async{
    var response = await Dio().get(
      Utils.RemoveFAV_URL+"$itemId/delete",options:
    Options(headers: {
      "lang":lang,
      "user":userId,
      "Accept-Language":lang,
    },),

    );
    print(response.data);
    if(response.data["status"]=="success")
    {
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
      (lang,userId,orderId,coupon)async{
    emit(GetLoadingCouponCartDateState());
    var response = await Dio().post(
        Utils.CheckCupounCart_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId,
    }),
        data: {
          "order_id":orderId,
          "coupon":coupon,
        }
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessCouponCartDateState());
      Fluttertoast.showToast(msg: "don");
      getCartData(lang);
    }else{
      Fluttertoast.showToast(msg: "This Coupon Not Correct",
          backgroundColor: customColor);
      emit(GetErrorCouponCartDateState("Coupon Not Valid"));

    }
  }


}
