import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/domain/use_cases/login_use_case.dart';
import 'package:ecommerce/features/auth/presentation/screens/login/cubit/login_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase}) : super(LoginInitialState());

  var emailController = TextEditingController(text: 'amira14@route.com');
  var passwordController = TextEditingController(text: 'Amira1234');

  //todo: hold data - handle logic
  void login() async {
    emit(LoginLoadingState());
    var either = await loginUseCase.invoke(
      emailController.text,
      passwordController.text,
    );
    either.fold((l) {
      emit(LoginErrorState(failures: l));
    }, (response) {
      emit(LoginSuccessState(responseEntity: response));
    });
  }
}