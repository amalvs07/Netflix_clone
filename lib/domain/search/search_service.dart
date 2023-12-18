import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/search/model/search_respo/search_respo.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchRespo>> searchMovies({
    required String movieQuery,
  });
}
