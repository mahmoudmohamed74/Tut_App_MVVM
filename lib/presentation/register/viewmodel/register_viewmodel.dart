import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:flutter_advanced/app/functions.dart';
import 'package:flutter_advanced/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/freezed_data_classes.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController userNameStreamController = StreamController<String>.broadcast();
  StreamController mobileNumberStreamController = StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController = StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast(); // file for picture
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast(); // no data in controller
  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  // --input

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputEmail => userNameStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      // store register object with data
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset user name value in register object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // store register object with data
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset countryCode value in register object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      // store register object with data
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (_isMobileNumberValid(mobileNumber)) {
      // store register object with data
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value in register object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      // store register object with data
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      // store register object with data
      registerObject = registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  register() async {
    // 1 show loading state
    // 2 execute func
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        registerObject.userName,
        registerObject.countryMobileCode,
        registerObject.mobileNumber,
        registerObject.email,
        registerObject.password,
        registerObject.profilePicture,
      ),
    ))
        .fold(
      (failure) => {
        inputState.add(
          ErrorState(StateRendererType.popupErrorState, failure.message),
        ),
      },
      (data) {
        inputState.add(ContentState());
        // isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  // --output

  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream.map(
        (userName) => _isUserNameValid(userName),
      );

  @override
  // used the previous stream as input
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserName) => isUserName ? null : AppStrings.userNameInvalid);

  @override
  Stream<bool> get outputIsEmailValid => emailStreamController.stream.map(
        (email) => isEmailValid(email),
      );

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((isEmail) => isEmail ? null : AppStrings.invalidEmail);

  @override
  Stream<bool> get outputIsMobileNumberValid => mobileNumberStreamController.stream.map(
        (mobileNumber) => _isMobileNumberValid(mobileNumber),
      );

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid
      .map((isMobileNumberValid) => isMobileNumberValid ? null : AppStrings.invalidMobileNumber);

  @override
  Stream<bool> get outputIsPasswordValid =>
      passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : AppStrings.invalidPassword);

  @override
  Stream<File> get outputIsProfilePictureValid =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // --private functions

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    // call it in every set func to check every change in every field at once
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName; // depended on the output of the other streamer
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<File> get outputIsProfilePictureValid;
  Stream<bool> get outputAreAllInputsValid;
}
