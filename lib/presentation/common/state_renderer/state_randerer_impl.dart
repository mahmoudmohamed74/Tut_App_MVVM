import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading (popup , fullState)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState({
    required this.stateRendererType,
    String message = AppStrings.loading,
  });
  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}
