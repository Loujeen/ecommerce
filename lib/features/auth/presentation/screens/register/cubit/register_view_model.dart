import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/domain/use_cases/register_use_case.dart';
import 'package:ecommerce/features/auth/presentation/screens/register/cubit/register_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterUseCase registerUseCase;

  RegisterViewModel({required this.registerUseCase})
      : super(RegisterInitialState());
  var nameController = TextEditingController(text: 'Amira');
  var emailController = TextEditingController(text: 'amira14@route.com');
  var passwordController = TextEditingController(text: 'Amira1234');
  var rePasswordController = TextEditingController(text: 'Amira1234');
  var phoneController = TextEditingController(text: '01232323232');

  //todo: hold data - handle logic
  void register() async {
    emit(RegisterLoadingState());
    var either = await registerUseCase.invoke(
        nameController.text,
        emailController.text,
        passwordController.text,
        rePasswordController.text,
        phoneController.text);
    either.fold((l) {
      emit(RegisterErrorState(failures: l));
    }, (response) {
      emit(RegisterSuccessState(responseEntity: response));
    });
  }
}