import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants/utils.dart';
import '../../../home/home_screen.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  static ReviewCubit get(context)=>BlocProvider.of(context);

  void sendReview(lang,productId,userId,comment,rate,email,context)async{
    emit(GetLoadingProductReviewState());
    var response = await Dio().post(
        "${Utils.SubmitReview_URL}$productId/submitReview",options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
      "user":userId,
    }),data: {
          "comment":comment,
          "rate":rate
    }
    );
    if(response.data["status"]=="success")
    {
      print(response.data);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder:
              (context)=>HomeScreen(
            Localizations.localeOf(context).languageCode,0,
            email: email,
          )), (route) => false);
      emit(GetSuccessProductReviewState());
    }else{
      emit(GetErrorProductReviewState(response.data["message"]));
    }
  }

}
