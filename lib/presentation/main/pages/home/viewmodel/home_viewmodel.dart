import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
// input
  @override
  void start() {
    // get ui
    _getHomeData();
  }

  @override
  void dispose() {
    _dataStreamController.close();

    super.dispose();
  }

  _getHomeData() async // get API
  {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );
    (await _homeUseCase.execute(Void)).fold(
      (failure) => {
        inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message),
        ),
      },
      (homeObject) {
        inputState.add(ContentState());
        inputHomeData.add(
          HomeViewObject(
            homeObject.data.banners,
            homeObject.data.services,
            homeObject.data.stores,
          ),
        );
      },
    );
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData => _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<BannerAd> banners;
  List<Service> services;
  List<Store> stores;
  HomeViewObject(this.banners, this.services, this.stores);
}
