import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/models/product_model.dart';

import '../../../constants/utils.dart';
import '../../../sharedPreferences.dart';
import 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(InitialOfferState());
  static OfferCubit get(context)=>BlocProvider.of(context);
  List<ProductsModel> productsOfferList=[];

  Future<List<ProductsModel>?> getProductesOffer(userId)async{
    emit(GetLoadingProductsOfferState());
    final response = await http.get(
      Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL+"&on_sale=true"),
    );
    print(response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      emit(GetSuccessProductsOfferState());
      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorProductsOfferState(json.decode(response.body)["message"]));
    }
  }
  void getProOffer(){
    MySharedPreferences().getUserId().then((value) {
      getProductesOffer(value).then((value) {
        productsOfferList = value!;
      });
    });
  }


}