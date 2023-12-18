import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/downloads/i_download_repo.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final DummyvideoUrls = [
  "https://pagalstatus.com/wp-content/uploads/2023/07/Batman-Whatsapp-Status-Videosl.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/Batman-Attitude-Whatsapp-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/Hollywood-Movie-Whatsapp-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/The-Flash-Whatsapp-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/Wheel-Of-Time-Devil-Entry-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2021/10/Game-Of-Thrones-Dragon-Scene-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2022/06/Avengers-2022-Whatsapp-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/Lion-King-Whatsapp-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2021/10/Avengers-Attitude-Full-Screen-Whatsapp-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/Wild-Birds-Animals-Collection-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2021/10/Game-Of-Thrones-Whatsapp-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2021/06/Marvel-Avengers-Spider-Man-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2022/07/Rolls-Royce-Car-2022-Whatsapp-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2023/07/Attitude-Fox-4k-Status-Videos.mp4",
  "https://pagalstatus.com/wp-content/uploads/2021/10/Jon-Snow-Attitude-Whatsapp-Status-Video.mp4",
  "https://pagalstatus.com/wp-content/uploads/2022/06/Thor-Amazing-Full-Screen-Whatsapp-Status-Video.mp4",
];

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadRepo iDownloadRepo,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(const FastLaughState(
        isLoading: false,
        isError: true,
        videoList: [],
      ));

      //get trending movies

      final _result = await iDownloadRepo.getDownloadImages();

      final _state = _result.fold(
        (f) {
          return const FastLaughState(
            isLoading: false,
            isError: true,
            videoList: [],
          );
        },
        (resp) {
          return FastLaughState(
            isLoading: false,
            isError: false,
            videoList: resp,
          );
        },
      );
      emit(_state);

      //send ui
    });
  }
}
