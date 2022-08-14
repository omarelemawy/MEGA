

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}
class SuccessLoginState extends LoginState {}
class ErrorLoginState extends LoginState {
  ErrorLoginState(this.error);
  String error;
}

class ForgetPassLoadingLoginState extends LoginState {}
class ForgetPassSuccessLoginState extends LoginState {}
class ForgetPassErrorLoginState extends LoginState {
  ForgetPassErrorLoginState(this.error);
  String error;
}

class ResetPassLoadingLoginState extends LoginState {}

class ResetPassSuccessLoginState extends LoginState {}

class ResetPassErrorLoginState extends LoginState {
  ResetPassErrorLoginState(this.error);
  String error;
}
