import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/presentation/register/viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _mobileNumberEditingController = TextEditingController();

  _bind() {
    _viewModel.start(); // connect view to viewmodel
    _userNameEditingController.addListener(
      () => _viewModel.setUserName(_userNameEditingController.text),
    );
    _emailEditingController.addListener(
      () => _viewModel.setEmail(_emailEditingController.text),
    );
    _passwordEditingController.addListener(
      () => _viewModel.setPassword(_passwordEditingController.text),
    );
    _mobileNumberEditingController.addListener(
      () => _viewModel.setMobileNumber(_mobileNumberEditingController.text),
    );
    // _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen(
    //   (isLoggedIn) {
    //     if (isLoggedIn) {
    //       SchedulerBinding.instance.addPostFrameCallback((_) {
    //         _appPreferences.setUserLoggedIn();
    //         Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
    //       });
    //     }
    //   },
    // );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
