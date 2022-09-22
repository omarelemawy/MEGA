import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:meta/meta.dart';

import '../../../../constants/utils.dart';
import '../../../../models/order_data_model.dart';
import 'package:http/http.dart' as http;
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context)=>BlocProvider.of(context);
  List<OrderData>? ordersListData;

  Future<List<OrderData>?> getOrderList(user,token)async{

    var response = await http.get(
        Uri.parse(Utils.OrdersList_URL+'?'+Utils.BASEData_URL+"&customer=$user"),
       headers: {
      "authorization":"Bearer ${token}",
    }
    );
    Iterable l = json.decode(response.body);
    if(response.statusCode==200||response.statusCode==201)
    {
      emit(GetSuccessOrderListOrderState());
      return List<OrderData>.from(l.map((model)=> OrderData.fromJson(model)));
    }else{
      emit(GetErrorOrderListOrderState(json.decode(response.body)["message"]));
    }
  }

  void getOrderL(token){
    MySharedPreferences().getUserId().then((value1) {
      print(value1);
        getOrderList(value1,token).then((value) {
          ordersListData = value!;
      });
    });
  }
  void getToken()
  async {
    emit(GetLoadingOrderListOrderState());
    var response = await Dio().post(
        Utils.GetToken_URL+"?username=wesam&password=mCJz)tV0FOZ2%jM8%26^E!tWvT");

    if(response.statusCode==200){

      print(response.data["token"]);
      getOrderL(response.data["token"]);
    }else{
      print(response.data);
    }
  }
}
