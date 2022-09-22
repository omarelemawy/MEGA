import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnon/localization/localization_constants.dart';
import 'package:gnon/models/product_detail_model.dart';
import 'package:gnon/models/setting_model.dart';
import 'package:gnon/screens/Cart/checkout_screen.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../constants/utils.dart';
import '../../../../models/category_model.dart';
import '../../../models/cart_data_model.dart';
import '../../../models/product_model.dart';
import '../../../models/review_product.dart';
import 'home_state.dart';
import 'package:http/http.dart' as http;


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit get(context)=>BlocProvider.of(context);
  List<CategoryListModel> categoryList=[];
  List<ProductsModel> productList=[];
  List<ProductsModel>? productListRelated;
  late Database database;
  List<ReviewProductModel> productListReview=[];
  bool? isLike=false;

  bool? isLikeCard=false;

  ProductDetailsModel? productDetails;
  SettingsModel? settingsModel;
  List<String>? photos=[];
  List<Map> tasks =[];
  List favList =[];


  Future<List<CategoryListModel>?> getCategory()async {
    emit(GetLoadingHomeState());

    final response = await http.get(
        Uri.parse(Utils.Category_URL+'?'+Utils.BASEData_URL),
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
  void getCat(){
    getCategory().then((value) {
      categoryList=value!;
    });
  }


  Future<List<ProductsModel>?> getProductes
      (userId)async{


    emit(GetLoadingProductState());
    final response = await http.get(
      Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL),
    );
    print(response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      emit(GetSuccessProductState());

      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorProductState(json.decode(response.body)["message"]));
    }
  }

  void getProduct(){
     MySharedPreferences().getUserId().then((value) {
       getProductes(value).then((value) {
         productList=value!;
       });
     });

  }





  void getDataFromDatabase(String id)
  {
    favList=[];
    openDatabase(
      'favorite.db',
    ).then((value)
    {
      database=value;
      database.rawQuery('SELECT * FROM tasks').then(
              (value)  {
            tasks=value;
            print(tasks);
            for (var element in tasks) {
              favList.add(element["title"]);
            }
            favList.forEach((element) {
              if(element==id){
                isLike=true;
              }
            });
            print(favList);
            emit(GetDatabaseState());
          });
    });



  }

  void getDataFromDatabaseCard(List<ProductsModel>?  list,index)
  {
    favList=[];
    openDatabase(
        'favorite.db',
    ).then((value)
    {
      database=value;
      database.rawQuery('SELECT * FROM tasks').then(
              (value)  {
            tasks=value;
            print(tasks);
            for (var element in tasks) {
              favList.add(element["title"]);
            }
            isLikedCard(list,index);
            emit(GetDatabaseState());
          });
    });



  }


  void isLikedCard(List<ProductsModel>?  list,index){
    print(favList.toString()+"egfjeiogjie");
    print(list![0].id);
    print(index);
    favList.forEach((element) {
      print(element + list[index!].id.toString());
      if(element==list[index!].id.toString()){
        isLikeCard=true;
        print("object");
      }
    });
    print("objectvdvdvdvdv");
  }

  void deleteDate({required String id})
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE title = ?',
        [ '$id' ]).then((value)
    {
      isLike=false;

      print("deleteDate  $value");
      emit(DeleteDataBaseState());
    }
    );

  }

  void deleteDateCard({required String id})
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE title = ?',
        [ '$id' ]).then((value)
    {
      isLikeCard=false;

      print("deleteDate  $value");
      emit(DeleteDataBaseState());
    }
    );

  }

  Future insertToDatabase({required String title})async
  {
    print(title);
    print("insertToDatabase");
    return await database.transaction((txn) {
      return   txn.rawInsert('INSERT INTO tasks( title) VALUES("$title")').
      then((value) {
        print("$value insert Don");
        emit(InsertDatabaseState());
        getDataFromDatabase(title);
      }).catchError((error){
        print(error.toString());
      });
    });
  }

  Future insertToDatabaseCard(List<ProductsModel>?  list,index,{required String title})async
  {
    print(list);
    print("insertToDatabase");
    return await database.transaction((txn) {
      return   txn.rawInsert('INSERT INTO tasks( title) VALUES("$title")').
      then((value) {
        print("$value insert Don");
        getDataFromDatabaseCard(list,index);
        emit(InsertDatabaseState());
      }).catchError((error){
        print(error.toString());
      });
    });
  }



  Future<SettingsModel?> getSettingsData
      ()async{
    emit(GetLoadingProductState());
    var response = await Dio().get(
      Utils.Settings_URL
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

  void getSettings(){
    print("jsdoifsfewsfe");
      getSettingsData().then((value) {
        settingsModel=value!;
      });

  }


  void addToCart(lang,userId,productId,price,context)async{
    emit(AddToCartLoadingProductDetailsState());
    print(userId);
    print(productId);
    var response = await Dio().post(
        Utils.AddTocart_URL+"?"+Utils.BASEData_URL,
        options: Options(
            headers: {
              "X-WC-Store-API-Nonce": "wc_store_api",
              "authorization": "Bearer ${userId}"
            }
        )
      ,data: {
        "id":productId,
        "quantity":"1"
      }
    );
    print(response.data);
    if(response.statusCode == 201||response.statusCode == 200)
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
      Navigator.push(context, MaterialPageRoute(builder:
          (context)=> CheckOutScreen()
      ));
    }
  }


  List<ProductsModel> productsOfferList=[];

  Future<List<ProductsModel>?> getProductesOffer(userId)async{

    emit(GetLoadingProductsOfferHomeState());
    final response = await http.get(
      Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL+"&on_sale=true"),
    );
    print(response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      emit(GetSuccessProductsOfferHomeState());

      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorProductsOfferHomeState(json.decode(response.body)["message"]));
    }
  }
  void getProOffer(){
    MySharedPreferences().getUserId().then((value) {
      getProductesOffer(value).then((value) {
        productsOfferList = value!;
      });
    });
  }


  List<ProductsModel> productsYouMayLikeHome=[];

  Future<List<ProductsModel>?> getproductsYouMayLikeHome(userId)async{

    emit(GetLoadingYouMayLikeHomeHomeState());
    final response = await http.get(
      Uri.parse(Utils.CategoryProduct_URL+"?"+Utils.BASEData_URL+"&orderby=date&page=1"),
    );
    print(response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      emit(GetSuccessYouMayLikeHomeHomeState());

      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorYouMayLikeHomeHomeState(json.decode(response.body)["message"]));
    }
  }
  void getproductsYouMayLike(){
    MySharedPreferences().getUserId().then((value) {
      getproductsYouMayLikeHome(value).then((value) {
        productsYouMayLikeHome = value!;
      });
    });
  }




  Future<ProductDetailsModel?> getProductDetails
      (lang,id,userId)async{
    print(id);
    emit(GetLoadingProductDetailsState());
    var response = await Dio().get(
      Utils.ProductDetails_URL+"/$id"+'?'+Utils.BASEData_URL,);
    print(response.data);
    if(response.statusCode==200)
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

        getProductDetailsRela(lang,productDetails!.relatedIds);
        getProductRev(lang,productDetails!.id);

        productDetails!.images!.forEach((element) {
          photos!.add(element.src!);
        });
      });
    });
  }


  Future<List<ProductsModel>?> getProductDetailsRelated
      (lang,id,userId)async{
    print(id);
    emit(GetLoadingProductDetailsRelatedDetailsState());
    final response = await http.get(
      Uri.parse(Utils.ProductDetails_URL+'?'+Utils.BASEData_URL+"&include=$id"),
    );
    print("ooooooooooo"+response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      print(response.body);
      emit(GetSuccessProductDetailsRelatedDetailsState());
      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorProductDetailsRelatedDetailsState(json.decode(response.body)["message"]));
    }
  }
  void getProductDetailsRela(lang,id){
    MySharedPreferences().getUserId().then((value) {
      getProductDetailsRelated(lang, id,value).then((value) {
        productListRelated = value!;
      });
    });
  }



  Future<List<ReviewProductModel>?> getProductReview
      (lang,id,userId)async{
    print(id);
    emit(GetLoadingProductReviewDetailsState());
    final response = await http.get(
      Uri.parse(Utils.ProductReview_URL+'?'+Utils.BASEData_URL+"&p=$id"),
    );
    print("ooooooooooo"+response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      print(response.body);
      emit(GetSuccessProductReviewDetailsState());
      return List<ReviewProductModel>.from(l.map((model)=> ReviewProductModel.fromJson(model)));
    }else{
      emit(GetErrorProductReviewDetailsState(json.decode(response.body)["message"]));
    }
  }

  void getProductRev(lang,id)
  {
    MySharedPreferences().getUserId().then((value) {
      getProductReview(lang, id,value).then((value) {
        productListReview = value!;
      });
    });
  }



  List<ItemsOfCart>? cartDataModel;

  Future<List<ItemsOfCart>?> getCartDetails
      ( userId) async {
    emit(GetLoadingCartDateHomeState());
    var response = await Dio().get(
        Utils.CartDetails_URL + "?" + Utils.BASEData_URL,
        options: Options(
            headers: {
              "X-WC-Store-API-Nonce": "wc_store_api",
              "authorization": "Bearer ${userId}"
            }
        )
    );

    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 200) {
      emit(GetSuccessCartDateHomeState());
      return CartDataModel
          .fromJson(response.data)
          .items;
    } else {
      emit(GetErrorCartDateHomeState(response.data["message"]));
    }
  }


  bool? isLogin=false;

  void getCartData() {
    MySharedPreferences.getUserGetToken().then((value) {
      print(value);
      if (value == "" || value == null) {
        isLogin = false;
      } else {
        isLogin = true;
        getCartDetails(value).then((value) {
          cartDataModel = value!;
        });
      }
    });
  }
}

