import 'package:flutter/widgets.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

enum StateRendererType {
// popup state dialog

  popupLoadingState,
  popupErrorState,

// full screen states

  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

// general

  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
