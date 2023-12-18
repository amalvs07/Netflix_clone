import 'package:dartz/dartz.dart';

import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';

abstract class IDownloadRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadImages();
}
