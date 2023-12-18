import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/downloads/i_download_repo.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
part 'downloads_bloc.freezed.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadRepo _downloadRepo;
  DownloadsBloc(this._downloadRepo) : super(DownloadsState.inital()) {
    on<_GetDownloadsImage>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        downloadFailureOrSuccessOption: none(),
      ));
      final Either<MainFailure, List<Downloads>> downloadsOptions =
          await _downloadRepo.getDownloadImages();
      log(downloadsOptions.toString());

      emit(downloadsOptions.fold(
          (failure) => state.copyWith(
              isLoading: false,
              downloadFailureOrSuccessOption: Some(Left(failure))),
          (success) => state.copyWith(
                isLoading: false,
                downloads: success,
                downloadFailureOrSuccessOption: Some(Right(success)),
              )));
    });
  }
}
