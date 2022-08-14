import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/models/product_model.dart';

import '../../../constants/utils.dart';
import '../../../sharedPreferences.dart';
import 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(InitialOfferState());
  static OfferCubit get(context)=>BlocProvider.of(context);
  List<ProductsModel> productsOfferList=[];

  Future<List<ProductsModel>?> getProductesOffer(lang,userId)async{
    emit(GetLoadingProductsOfferState());
    var response = await Dio().get(
        Utils.CategoryProduct_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    }),
      queryParameters: {
          "offer":1
      }
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessProductsOfferState());
      print(ProductsCategoryModel.fromJson(response.data).data![0].name);
      return ProductsCategoryModel.fromJson(response.data).data;
    }else{
      emit(GetErrorProductsOfferState(response.data["message"]));
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