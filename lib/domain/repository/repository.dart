import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests); //تعريف الfunc
}
