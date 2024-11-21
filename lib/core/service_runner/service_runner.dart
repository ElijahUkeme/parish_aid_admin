import 'dart:async';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/errors/exceptions.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/network_info/network_info.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';

class ServiceRunner<Type> {
  final NetworkInfo networkInfo;
  final Future<bool> Function(Type)? cacheTask;

  ServiceRunner({required this.networkInfo, this.cacheTask});

  Future<Either<Failure, Type>> runNetworkTask(
      Future<Type> Function() task) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await task.call();

        //run cache task
        if (cacheTask != null) {
          cacheTask!(result);
        }

        //Return the right side of the either type
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(serverFailure, e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(cacheFailure, e.message));
      } on HandshakeException catch (e) {
        return const Left(InternetFailure(networkFailure, networkError));
      } on SocketException catch (e) {
        return const Left(InternetFailure(networkFailure, networkError));
      } on FormatException {
        return const Left(ProcessFailure(processFailure, formatError));
      } on TimeoutException {
        return const Left(InternetFailure(networkFailure, timeoutError));
      } on Exception {
        return const Left(UnknownFailure(unknownError));
      }
    } else {
      //Fluttertoast.showToast(msg: "No Internet");
      return const Left(InternetFailure(networkFailure, noInternetError));
    }
  }

  Future<Either<Failure, Type>> runCacheTask(
      Future<Type> Function() task) async {
    try {
      return Right(await task.call());
    } on ServerException catch (e) {
      return Left(ServerFailure(serverFailure, e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(cacheFailure, e.message));
    } on HandshakeException catch (e) {
      return const Left(InternetFailure(networkFailure, networkError));
    } on SocketException catch (e) {
      return const Left(InternetFailure(networkFailure, noInternetError));
    } on FormatException catch (e) {
      return const Left(ProcessFailure(processFailure, formatError));
    } on TimeoutException catch (e) {
      return const Left(InternetFailure(networkFailure, timeoutError));
    } on Exception {
      return const Left(UnknownFailure(unknownError));
    }
  }
}
