part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class GetLoadingOrderListOrderState extends OrderState {}
class GetSuccessOrderListOrderState extends OrderState {}
class GetErrorOrderListOrderState extends OrderState {
  GetErrorOrderListOrderState(this.error);
  String error;
}
