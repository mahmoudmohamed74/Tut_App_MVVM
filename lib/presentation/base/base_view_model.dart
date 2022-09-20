import 'dart:async';

import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and func at any view model
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStreamController.sink; // initialize

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // start view model jop

  void dispose(); // will called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
