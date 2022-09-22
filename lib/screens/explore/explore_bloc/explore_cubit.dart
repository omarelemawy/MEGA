import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/sharedPreferences.dart';

import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(InitialExploreState());
  static ExploreCubit get(context)=>BlocProvider.of(context);

  List<ProductsModel> productList=[];

/*  Future<List<ProductsModel>?> getExploreItem
      (lang,name,userId)async{
    emit(GetLoadingExploreState());
    var response = await Dio().get(
        Utils.CategoryProduct_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    }),
      queryParameters: {
          "name":name
      }
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessExploreState());
      return ProductsModel.fromJson(response.data).data;
    }else{
      emit(GetErrorExploreState(response.data["message"]));
    }
  }

  void getExplore(lang,name){
    MySharedPreferences().getUserId().then((value){
      getExploreItem(lang, name,value).then((value) {
        productList = value!;
      });
    });
  }*/
  Future<List<ProductsModel>?> getExploreItem
      (name,userId)async{

    emit(GetLoadingExploreState());
    final response = await http.get(
      Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL+"&search=$name"),
    );
    print(response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      emit(GetSuccessExploreState());

      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorExploreState(json.decode(response.body)["message"]));
    }
  }



  void getExplore(name){
    MySharedPreferences().getUserId().then((value) {
      getExploreItem(name,value).then((value) {
        productList=value!;
      });
    });

  }

}