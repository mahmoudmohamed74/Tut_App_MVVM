import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannersStreamController = BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController = BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController = BehaviorSubject<List<Store>>();

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
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
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
        inputBanners.add(homeObject.data?.banners);
        inputServices.add(homeObject.data?.services);
        inputStores.add(homeObject.data?.stores);
      },
    );
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // output
  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores => _storesStreamController.stream.map(
        (stores) => stores,
      );
}

abstract class HomeViewModelInput {
  Sink get inputBanners;
  Sink get inputServices;
  Sink get inputStores;
}

abstract class HomeViewModelOutput {
  Stream<List<BannerAd>> get outputBanners;
  Stream<List<Service>> get outputServices;
  Stream<List<Store>> get outputStores;
}
