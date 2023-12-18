

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/api_end_points.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/hot_and_new/HotAndNewsService.dart';
import 'package:netflix_clone/domain/hot_and_new/hot_and_new_respo/hot_and_new_respo.dart';


@LazySingleton(as: HotAndNewService)
class HotAndNewImpl implements HotAndNewService {
  @override
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewMovieData() async{
    // TODO: implement getHotAndNewMovieData
     try {
      final Response response = await Dio(BaseOptions())
          .get(ApiEndPoints.HotAndNewDiscoverMovies,);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final resultData = HotAndNewRespo.fromJson(response.data);

        return Right(resultData);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioException catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewTVData() async{
    // TODO: implement getHotAndNewTVData
     try {
      final Response response = await Dio(BaseOptions())
          .get(ApiEndPoints.HotAndNewDiscoverTv,);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final resultDatas = HotAndNewRespo.fromJson(response.data);

        return Right(resultDatas);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioException catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
  
}