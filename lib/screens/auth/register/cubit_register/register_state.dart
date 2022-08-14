

abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}
class SuccessRegisterState extends RegisterState {}
class ErrorRegisterState extends RegisterState {
  ErrorRegisterState(
      this.error,
      {this.errorEmail,
      this.errorPass,
      this.errorPhone,}
      );
  String error;
  String? errorEmail;
  String? errorPass;
  String? errorPhone;
}


