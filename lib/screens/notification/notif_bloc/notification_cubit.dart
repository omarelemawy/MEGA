import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/models/notificattion_model.dart';

import '../../../constants/utils.dart';
import '../../../sharedPreferences.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context)=>BlocProvider.of(context);

  List<Notification>? notificationList=[];

  Future<List<Notification>?> getNotif
      (lang,userId)async{
    emit(GetLoadingNotificationState());
    var response = await Dio().get(
      Utils.Notifications_URL,options:
    Options(headers: {
      "lang":lang,
      "Accept-Language":lang,
       "user":userId
    }),
      queryParameters: {
        "page":1
      }
    );
    if(response.data["status"]=="success")
    {
      emit(GetSuccessNotificationState());
      return NotificationModel.fromJson(response.data).data;
    }else{
      emit(GetErrorNotificationState(response.data["message"]));
    }
  }

  void getNotifData(lang){
    MySharedPreferences().getUserId().then((value) {
      getNotif(lang,value).then((value) {
        notificationList = value!;
      });
    });
  }


}
