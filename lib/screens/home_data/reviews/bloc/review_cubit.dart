import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/utils.dart';
import '../../../home/home_screen.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  static ReviewCubit get(context)=>BlocProvider.of(context);


  void getToken(lang,productId,userId,comment,rate,email,context)
  async {

    var response = await Dio().post(
        Utils.GetToken_URL+"?username=wesam&password=mCJz)tV0FOZ2%jM8%26^E!tWvT");
    if(response.statusCode==200){
      print(response.data["token"]);
      sendReview(lang,productId,userId,comment,rate,email,context,response.data["token"]);
    }else{
      print(response.data);
    }
  }
  void sendReview(lang,productId,userId,comment,double  rate,email,context,token)
  async{

    emit(GetLoadingProductReviewState());
    var response = await http.post(
        Uri.parse(Utils.SubmitReview_URL+"?"+Utils.BASEData_URL),
        headers: {
          "authorization":"Bearer ${token}",
        },body: {
          "product_id":productId.toString(),
          "rating": rate.toInt().toString(),
          "review":comment,
          "reviewer":userId,
          "reviewer_email":email,
          "status":"hold"
    }
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200||response.statusCode==201)
    {
      print("response.body");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder:
              (context)=>HomeScreen(0,
            email: email,
          )), (route) => false);
      emit(GetSuccessProductReviewState());
    }else{
      print("response.bodyvsvscv");
      emit(GetErrorProductReviewState(json.decode(response.body)["message"]));
    }
  }

}
