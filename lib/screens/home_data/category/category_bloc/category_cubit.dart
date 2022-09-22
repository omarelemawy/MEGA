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
      Uri.parse(Utils.Category_URL+"?"+Utils.BASEData_URL+"&per_page=100"),
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
      (id,userId)async{
    print(id);
    emit(GetLoadingProductCategoryState());
    final response = await http.get(
      Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL+"&category=$id"),

    );
    print(response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      emit(GetSuccessProductCategoryState());
      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorProductCategoryState(json.decode(response.body)["message"]));
    }
  }

  void getProCat(id){
    MySharedPreferences().getUserId().then((value) {
      getProductOfCategory( id,value).then((value) {
        categoryProductList = value!;
      });
    });
  }
}
