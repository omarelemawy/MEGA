part of 'address_bloc.dart';


abstract class AddressState {}

class AddressInitial extends AddressState {}

class GetLoadingAddressState extends AddressState {}

class GetSuccessAddressState extends AddressState {}

class GetErrorAddressState extends AddressState {
  GetErrorAddressState(this.error);
  String error;
}


class GetLoadingGovernoratesAddressState extends AddressState {}

class GetSuccessGovernoratesAddressState extends AddressState {}

class GetErrorGovernoratesAddressState extends AddressState {
  GetErrorGovernoratesAddressState(this.error);
  String error;
}




class GetLoadingCityAddressState extends AddressState {}

class GetSuccessCityAddressState extends AddressState {}

class GetErrorCityAddressState extends AddressState {
  GetErrorCityAddressState(this.error);
  String error;
}

class GetLoadingCreateAddressState extends AddressState {}

class GetSuccessCreateAddressState extends AddressState {}

class GetErrorCreateAddressState extends AddressState {
  GetErrorCreateAddressState(this.error);
  String error;
}

class GetLoadingGetAddressListState extends AddressState {}

class GetSuccessGetAddressListState extends AddressState {}

class DeleteSuccessAddressState extends AddressState {}
class DeleteLoadingAddressState extends AddressState {}

class GetErrorGetAddressListState extends AddressState {
  GetErrorGetAddressListState(this.error);
  String error;
}

class GetLoadingCartDateState extends AddressState {}

class GetSuccessCartDateState extends AddressState {}


class GetErrorCartDateState extends AddressState {
  GetErrorCartDateState(this.error);
  String error;
}
class ChangeQuantityCartDateState extends AddressState {}


class GetLoadingCouponCartDateState extends AddressState {}

class GetSuccessCouponCartDateState extends AddressState {}


class GetErrorCouponCartDateState extends AddressState {
  GetErrorCouponCartDateState(this.error);
  String error;
}