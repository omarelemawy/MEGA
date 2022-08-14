
abstract class AccountState {}

class InitialAccountState extends AccountState {}


class LoadingAccountState extends AccountState {}

class ChangeLanguageAccountState extends AccountState {}

class SuccessAccountState extends AccountState {}
class ErrorAccountState extends AccountState {
  ErrorAccountState(this.error);
  String error;
}

class GetProfileLoadingAccountState extends AccountState {}

class GetProfileSuccessAccountState extends AccountState {}
class GetProfileErrorAccountState extends AccountState {
  GetProfileErrorAccountState(this.error);
  String error;
}
class UpdateProfileLoadingAccountState extends AccountState {}

class UpdateProfileSuccessAccountState extends AccountState {}
class UpdateProfileErrorAccountState extends AccountState {
  UpdateProfileErrorAccountState(this.error);
  String error;
}

class DeleteProfileLoadingAccountState extends AccountState {}
class DeleteProfileSuccessAccountState extends AccountState {}
class DeleteProfileErrorAccountState extends AccountState {
  DeleteProfileErrorAccountState(this.error);
  String error;
}