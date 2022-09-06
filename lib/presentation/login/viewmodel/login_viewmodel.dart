import 'dart:async';

import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject("", ""); // store data
  // inputs
  @override
  void dispose() //  ensure closing controllers
  {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword =>
      _passwordStreamController.sink; // update getter for sink

  @override
  Sink get inputUserName =>
      _userNameStreamController.sink; // update getter for sink

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName); // ناخده من اليوزر
    loginObject = loginObject.copyWith(userName: userName);
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

// outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _passwordIsValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _userNameIsValid(userName));

  bool _passwordIsValid(String password) //  عشان ترجعلي السترنج بوليان
  {
    return password.isNotEmpty;
  }

  bool _userNameIsValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();
  Sink get inputUserName; // to valid user & password
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}
