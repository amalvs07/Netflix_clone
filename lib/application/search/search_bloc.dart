import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/downloads/i_download_repo.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
import 'package:netflix_clone/domain/search/model/search_respo/result.dart';
import 'package:netflix_clone/domain/search/model/search_respo/search_respo.dart';
import 'package:netflix_clone/domain/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadRepo _iDownloadRepo;
  final SearchService _searchService;

  SearchBloc(this._iDownloadRepo, this._searchService)
      : super(SearchState.initial()) {
    // idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResultMovie: [],
          idleList: state.idleList,
          isLoading: false,
          isError: false,
        ));
        return;
      }
      emit(const SearchState(
        searchResultMovie: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final _result = await _iDownloadRepo.getDownloadImages();

      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            searchResultMovie: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (List<Downloads> lists) {
          return SearchState(
            searchResultMovie: [],
            idleList: lists,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_state);
    });
// search result state
    on<SearchMovie>((event, emit) async {
      emit(const SearchState(
        searchResultMovie: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            searchResultMovie: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (SearchRespo r) {
          return SearchState(
            searchResultMovie: r.results,
            idleList: [],
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_state);
    });
  }
}
