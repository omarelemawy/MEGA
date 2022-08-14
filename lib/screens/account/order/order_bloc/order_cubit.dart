import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/sharedPreferences.dart';
import 'package:meta/meta.dart';

import '../../../../constants/utils.dart';
import '../../../../models/order_list_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context)=>BlocProvider.of(context);
  List<OrderList> ordersListData=[];

  Future<List<OrderList>?> getOrderList(lang,user)async{
    emit(GetLoadingOrderListOrderState());
    var response = await Dio().get(
        Utils.OrdersList_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":user,
    })
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessOrderListOrderState());
      return OrderListDataModel.fromJson(response.data).data;
    }else{
      emit(GetErrorOrderListOrderState(response.data["message"]));
    }
  }
  void getOrderL(lang){
    MySharedPreferences().getUserId().then((value) {
      getOrderList(lang,value).then((value) {
        ordersListData=value!;
      });
    });
  }
}
