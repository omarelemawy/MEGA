import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_state.dart';
import '../../../../constants/utils.dart';
import '../../../../models/category_model.dart';
import '../../../../sharedPreferences.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialCategoryState());
  static CategoryCubit get(context)=>BlocProvider.of(context);
  List<CategoryListModel> categoryList=[];
  List<ProductsModel> categoryProductList=[];


  Future<List<CategoryListModel>?> getCategory(lang)async{
    emit(GetLoadingCategoryState());
    final response = await http.get(
      Uri.parse(Utils.Category_URL+'?consumer_key=ck_7b06588bcc97aea8ffd7025d81d468f7abd902a6&consumer_secret=cs_e792875f045471bbcbb999d8d841d37842ef3c5b'),
    );
    Iterable l = json.decode(response.body);
    if(response.statusCode == 200)
    {
      emit(GetSuccessCategoryState());
      return List<CategoryListModel>.from(l.map((model)=> CategoryListModel.fromJson(model)));
    }else{
      emit(GetErrorCategoryState(json.decode(response.body)["message"]));
    }
  }
  void getCat(lang){
    getCategory(lang).then((value) {
      categoryList=value!;
    });
  }

  Future<List<ProductsModel>?> getProductOfCategory
      (lang,id,userId)async{
    print(lang);
    emit(GetLoadingProductCategoryState());
    var response = await Dio().get(
        Utils.CategoryProduct_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId
    },),
      queryParameters: {
        "category":id
      }
    );
    print(response.data);
    if(response.data["status"]=="success")
    {
      emit(GetSuccessProductCategoryState());
      return ProductsCategoryModel.fromJson(response.data).data;
    }else{
      emit(GetErrorProductCategoryState(response.data["message"]));
    }
  }
  void getProCat(lang,id){
    MySharedPreferences().getUserId().then((value) {

      getProductOfCategory(lang, id,value).then((value) {
        categoryProductList = value!;
      });
    });
  }
}
