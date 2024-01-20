abstract class RegisterStates{}

class InitialLoginState extends RegisterStates{}

class UploadImageRegisterLoading extends RegisterStates{}

class UploadImageRegisterSuccess extends RegisterStates{}

class UploadImageRegisterError extends RegisterStates{}

class RegisterLoading extends RegisterStates{}

class RegisterSuccess extends RegisterStates{}

class RegisterError extends RegisterStates{
  String? message;
  RegisterError(this.message);
}
