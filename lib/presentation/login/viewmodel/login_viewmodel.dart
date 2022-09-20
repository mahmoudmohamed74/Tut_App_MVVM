// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_advanced/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/freezed_data_classes.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
//****************************  lec 71 important****************************

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", ""); // store data

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() //  ensure closing controllers
  {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areInputsValidStreamController.close();
  }

  @override
  void start() {
    // view model tell view  to show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword =>
      _passwordStreamController.sink; // update getter for sink

  @override
  Sink get inputUserName =>
      _userNameStreamController.sink; // update getter for sink

  @override
  Sink get inputAreInputsValid => _areInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName); // ناخده من اليوزر
    loginObject = loginObject.copyWith(userName: userName);
    inputAreInputsValid.add(null);
  }

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
      (failure) => {
        print(failure.message),
      },
      (data) => {
        print(data.customer?.name),
      },
    );
  }

// outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAreInputsValid =>
      _areInputsValidStreamController.stream.map(
        (_) => _areInputsValid(),
      );

  bool _isPasswordValid(String password) //  عشان ترجعلي السترنج بوليان
  {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _areInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName; // to valid user & password
  Sink get inputPassword;
  Sink get inputAreInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreInputsValid;
}
