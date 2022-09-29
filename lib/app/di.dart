import 'package:dio/dio.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:flutter_advanced/data/data_source/local_data_source.dart';
import 'package:flutter_advanced/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced/data/network/app_api.dart';
import 'package:flutter_advanced/data/network/dio_factory.dart';
import 'package:flutter_advanced/data/network/network_info.dart';
import 'package:flutter_advanced/data/repository/repository_impl.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';
import 'package:flutter_advanced/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_advanced/domain/usecase/home_usecase.dart';
import 'package:flutter_advanced/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced/domain/usecase/store_details_usecase.dart';
import 'package:flutter_advanced/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:flutter_advanced/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_advanced/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_advanced/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_advanced/presentation/store_details/view_model/store_details_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async
// save all generic dependencies will be used in all app

{
  // shared prefs instance

  final sherdPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sherdPrefs);

  // app prefs instance

  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );
  // dio factory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance()),
  );
  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(dio),
  );
// remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<AppServiceClient>()),
  );

// local data source
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance(), instance(), instance()),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance()),
    );
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(instance()),
    );
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance()),
    );

    instance.registerFactory<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(instance()),
    );
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(instance()),
    );

    instance.registerFactory<RegisterViewModel>(
      () => RegisterViewModel(instance()),
    );
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
      () => HomeUseCase(instance()),
    );

    instance.registerFactory<HomeViewModel>(
      () => HomeViewModel(instance()),
    );
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
      () => StoreDetailsUseCase(instance()),
    );

    instance.registerFactory<StoreDetailsViewModel>(
      () => StoreDetailsViewModel(instance()),
    );
  }
}
