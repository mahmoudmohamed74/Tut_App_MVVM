import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/domain/model/model.dart';

abstract class Repository // declare func
{
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequests);

  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);

  Future<Either<Failure, HomeObject>> getHomeResponse();
}
