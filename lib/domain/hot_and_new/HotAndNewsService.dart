import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/hot_and_new/hot_and_new_respo/hot_and_new_respo.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewMovieData();

  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewTVData();
}
