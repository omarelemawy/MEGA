import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/sharedPreferences.dart';

import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(InitialExploreState());
  static ExploreCubit get(context)=>BlocProvider.of(context);

  List<ProductsModel> productList=[];

  Future<List<ProductsModel>?> getExploreItem
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
      return ProductsCategoryModel.fromJson(response.data).data;
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
  }

}