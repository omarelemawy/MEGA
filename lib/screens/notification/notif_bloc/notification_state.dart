part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetLoadingNotificationState extends NotificationState {}

class GetSuccessNotificationState extends NotificationState {}

class GetErrorNotificationState extends NotificationState {
  GetErrorNotificationState(this.error);
  String error;
}
