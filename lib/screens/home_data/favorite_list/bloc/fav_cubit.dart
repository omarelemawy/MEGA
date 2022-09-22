import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../constants/utils.dart';
import '../../../../models/product_model.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(InitialFavState());
  static FavCubit get(context)=>BlocProvider.of(context);


  late Database database;
  List<Map> tasks =[];
  List favList =[];
  List<ProductsModel>? favProductList;

  Future<List<ProductsModel>?> getFavoriteData
      (id)async{
    print(id);
    emit(GetLoadingFavoriteProductState());
    final response = await http.get(
      Uri.parse(Utils.ProductDetails_URL+'?'+Utils.BASEData_URL+"&include=$id"),
    );
    print("ooooooooooo"+response.body);
    Iterable l = json.decode(response.body);

    if(response.statusCode == 200)
    {
      print(response.body);
      emit(GetSuccessFavoriteProductState());
      return List<ProductsModel>.from(l.map((model)=> ProductsModel.fromJson(model)));
    }else{
      emit(GetErrorFavoriteProductState(json.decode(response.body)["message"]));
    }
  }


  void getProductDetailsRela(id){
    getFavoriteData( id).then((value) {
      favProductList = value!;
    });
  }


  void createDataBase()
  {
    openDatabase(
        'favorite.db',
        version: 1,
        onCreate: (database, version) {
          print("Create DataBase");
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT)')
              .then((value) {
            print("Create Table");
          }).catchError((error) {
            print('Error is${error.toString()}');
          });
        },
        onOpen: (database) {
          getDataFromDatabase(database);
        }
    ).then((value)
    {
      database=value;
      emit(CreateDatabaseState());
    });
  }


  void getDataFromDatabaseFav()
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
            getProductDetailsRela(favList);
            emit(GetDatabaseState());
          });
    });

  }


  void getDataFromDatabase(database)
  {
    favList=[];
    database.rawQuery('SELECT * FROM tasks').then(
            (value)  {
          tasks=value;
          for (var element in tasks) {
            favList.add(element["title"]);

            print(favList);
          }
          emit(GetDatabaseState());
        });

  }

  void deleteDateCard({required String id})
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE title = ?',
        [ '$id' ]).then((value)
    {
      print("deleteDate  $value");
      getDataFromDatabaseFav();
      emit(DeleteDataBaseState());
    }
    );

  }

 /* Future insertToDatabase({required String title})async
  {
    return await database.transaction((txn) {
      return   txn.rawInsert('INSERT INTO tasks( title) VALUES("$title")').
      then((value) {
        print("$value insert Don");
        emit(InsertDatabaseState());
        getDataFromDatabase(database);

      }).catchError((error){
        print(error.toString());
      });
    });
  }


  void upDate({required String state,required int id})
  {
    database.rawUpdate(
        'UPDATE tasks SET  status = ? WHERE id = ?',
        [ "$state" , id ]).then((value)
    {
      emit(UbDateDataBaseState());
      getDataFromDatabase(database);
    }
    ).then((value) {
      print(value);
    });

  }

  void deleteDate({required int id})
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [ '$id' ]).then((value)
    {
      emit(DeleteDataBaseState());
      getDataFromDatabase(database);
    }
    ).then((value) {
      print(value);
    });

  }*/


/*  Future<List<ProductsModel>?> getProductFav
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
  */


  /*void makeDisLikeProduct(itemId,userId,lang)async{
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
  }*/
}