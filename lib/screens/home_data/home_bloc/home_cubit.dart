import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/localization/localization_constants.dart';
import 'package:gnon/models/product_detail_model.dart';
import 'package:gnon/models/setting_model.dart';
import 'package:gnon/sharedPreferences.dart';
import '../../../../constants/utils.dart';
import '../../../../models/category_model.dart';
import '../../../models/product_model.dart';
import 'home_state.dart';
import 'package:http/http.dart' as http;


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit get(context)=>BlocProvider.of(context);
  List<CategoryListModel> categoryList=[];
  List<ProductsModel> ProductList=[];
  ProductDetailsModel? productDetails;
  SettingsModel? settingsModel;
  List<String>? photos=[];



  Future<List<CategoryListModel>?> getCategory(lang)async {
    emit(GetLoadingHomeState());

    final response = await http.get(
        Uri.parse(Utils.Category_URL+'?consumer_key=ck_7b06588bcc97aea8ffd7025d81d468f7abd902a6&consumer_secret=cs_e792875f045471bbcbb999d8d841d37842ef3c5b'),
    );
    print(response.body);
    Iterable l = json.decode(response.body);
    if (response.statusCode == 200) {
      emit(GetSuccessHomeState());
      return List<CategoryListModel>.from(l.map((model)=> CategoryListModel.fromJson(model)));
    } else {
      emit(GetErrorHomeState(json.decode(response.body)["message"]));
    }
  }

  void getCat(lang){
    getCategory(lang).then((value) {
      categoryList=value!;
    });
  }

  Future<List<ProductsModel>?> getProductes
      (lang,userId)async{
    print(lang);
    emit(GetLoadingProductState());
    var response = await Dio().get(
        Utils.CategoryProduct_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    },),

    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(GetSuccessProductState());

      return ProductsCategoryModel.fromJson(response.data).data;
    }else{
      emit(GetErrorProductState(response.data["message"]));
    }
  }
  void getProduct(lang){
     MySharedPreferences().getUserId().then((value) {

       getProductes(lang,value).then((value) {
         ProductList=value!;
       });
     });

  }


  Future<ProductDetailsModel?> getProductDetails
      (lang,id,userId)async{
    print(lang);
    emit(GetLoadingProductDetailsState());
    var response = await Dio().get(
      Utils.ProductDetails_URL+"$id/details",options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    },),

    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      print(response.data);
      emit(GetSuccessProductDetailsState());
      return ProductDetailsModel.fromJson(response.data);
    }else{
      emit(GetErrorProductDetailsState(response.data["message"]));
    }
  }
  void getProdDetails(lang,id){
    MySharedPreferences().getUserId().then((value) {
      getProductDetails(lang, id,value).then((value) {
        productDetails = value;
        productDetails!.data!.product!.photos!.forEach((element) {
          photos!.add(element.url!);
        });
      });
    });
  }


  void makeLikeProduct(itemId,userId,lang,context)async{
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
          msg: getTranslated(context, "Added to Favorite")!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  void makeDisLikeProduct(itemId,userId,lang,context)async{
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
          msg: getTranslated(context, "Removed from Favorite")!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }

  Future<SettingsModel?> getSettingsData
      (lang,userId)async{
    print(lang);
    emit(GetLoadingProductState());
    var response = await Dio().get(
      Utils.Settings_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    },),

    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(GetSuccessProductState());

      return SettingsModel.fromJson(response.data);
    }else{
      emit(GetErrorProductState(response.data["message"]));
    }
  }
  void getSettings(lang){
    MySharedPreferences().getUserId().then((value) {
      getSettingsData(lang,value).then((value) {
        settingsModel=value!;
      });
    });

  }

  void addToCart(lang,userId,productId,price,context)async{
    emit(AddToCartLoadingProductDetailsState());
    print(userId);
    print(productId);
    var response = await Dio().post(
      Utils.AddTocart_URL,options:
    Options(headers: {
      "lang":lang,
      "user":userId,
      "Accept-Language":lang,
    },),
      data: {
        "product_id":productId,
        "price":price,
        "quantity":"1"
      }
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(AddToCartSuccessProductDetailsState());
      print(response.data);
      Fluttertoast.showToast(
          msg: getTranslated(context, "Added To cart Success")!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  List<ProductsModel> productsOfferList=[];

  Future<List<ProductsModel>?> getProductesOffer(lang,userId)async{
    emit(GetLoadingProductsOfferHomeState());
    var response = await Dio().get(
        Utils.CategoryProduct_URL,options:
    Options(headers: {"Authorization":{
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    }}),
        queryParameters: {
          "offer":1
        }
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessProductsOfferHomeState());
      print(ProductsCategoryModel.fromJson(response.data).data![0].name);
      return ProductsCategoryModel.fromJson(response.data).data;
    }else{
      emit(GetErrorProductsOfferHomeState(response.data["message"]));
    }
  }
  void getProOffer(lang){
    MySharedPreferences().getUserId().then((value) {
      getProductesOffer(lang,value).then((value) {
        productsOfferList = value!;
      });
    });
  }

}
/* final response = await http.get(
      Uri.parse(Utils.Category_URL+'?consumer_key=ck_7b06588bcc97aea8ffd7025d81d468f7abd902a6&consumer_secret=cs_e792875f045471bbcbb999d8d841d37842ef3c5b'),
      // Send authorization headers to the backend.
      headers:

      {
        "Content-type": "application/json",
        // "Authorization": "="
        */
/*{
          "oauth_consumer_key":"ck_d9f6e89085559a11dc182ee5bf00a7b5698c6988",
          "oauth_nonce":"2PhTZt8mXMg",
          "oauth_signature":"S1vUAf6hrIPRamAA7H8095ZssDs%3D",
          "oauth_signature_method":"HMAC-SHA1",
          "oauth_timestamp":"1662454689",
          "oauth_version":"1.0",
        }*//*
      },
    );*/

/*,options:
    Options(headers: {"Authorization":{
      "oauth_consumer_key":"ck_d9f6e89085559a11dc182ee5bf00a7b5698c6988",
      "oauth_nonce":"2PhTZt8mXMg",
      "oauth_signature":"S1vUAf6hrIPRamAA7H8095ZssDs%3D",
      "oauth_signature_method":"HMAC-SHA1",
      "oauth_timestamp":"1662454689",
      "oauth_version":"1.0",
    }})*/