import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/models/product_model.dart';
import 'package:gnon/screens/home_data/category/category_bloc/category_state.dart';
import '../../../../constants/utils.dart';
import '../../../../models/category_model.dart';
import '../../../../sharedPreferences.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialCategoryState());
  static CategoryCubit get(context)=>BlocProvider.of(context);
  List<Category> categoryList=[];
  List<ProductsModel> categoryProductList=[];


  Future<List<Category>?> getCategory(lang)async{
    emit(GetLoadingCategoryState());
    var response = await Dio().get(
        Utils.Category_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
    })
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessCategoryState());
      return CategoryModel.fromJson(response.data).data;
    }else{
      emit(GetErrorCategoryState(response.data["message"]));
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
