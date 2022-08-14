import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../constants/utils.dart';
import '../../../../models/product_detail_model.dart';
import '../../../../models/product_model.dart';
import '../../../../sharedPreferences.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(InitialFavState());
  static FavCubit get(context)=>BlocProvider.of(context);
  List<ProductsModel> productList=[];
  Future<List<ProductsModel>?> getProductFav
      (lang,userId)async{
    print(lang);
    emit(GetLoadingFavState());
    var response = await Dio().get(
      Utils.GETFAVList_URL,options:
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
      emit(GetSuccessFavState());
      return ProductsCategoryModel.fromJson(response.data).data;
    }else{
      emit(GetErrorFavState(response.data["message"]));
    }
  }
  void getProdFav(lang){
    MySharedPreferences().getUserId().then((value) {
      getProductFav(lang,value).then((value) {
        productList = value!;
      });
    });
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
      getProdFav(lang);
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
}