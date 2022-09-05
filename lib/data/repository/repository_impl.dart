import 'package:flutter_advanced/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced/data/mapper/mapper.dart';
import 'package:flutter_advanced/data/network/error_handler.dart';
import 'package:flutter_advanced/data/network/network_info.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(
            Failure(
              ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
