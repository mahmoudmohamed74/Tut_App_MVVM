import 'dart:async';

import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:flutter_advanced/presentation/base/base_view_model.dart';
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
    // TODO: implement start
  }
  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => throw _bannersStreamController.sink;

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
