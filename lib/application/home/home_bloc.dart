import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
import 'package:netflix_clone/domain/hot_and_new/HotAndNewsService.dart';
import 'package:netflix_clone/domain/hot_and_new/hot_and_new_respo/hot_and_new_respo.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HotAndNewService _HomeService;
  HomeBloc(this._HomeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>((event, emit) async {
      emit(state.copyWith(isLoading: true, hasError: false));
      final _movieResult = await _HomeService.getHotAndNewMovieData();
      final _tvResult = await _HomeService.getHotAndNewTVData();

    final _state1=  _movieResult.fold((MainFailure f) {
        return 
           HomeState(
            StateId: DateTime.now().microsecond.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramaMovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true);
        
      }, (HotAndNewRespo respo) {
        final pastYearLists= respo.results;
        pastYearLists.shuffle();
final trendingLists= respo.results;
trendingLists.shuffle();
final tenseDramaLists= respo.results;
tenseDramaLists.shuffle();
final southIndianLists= respo.results;
southIndianLists.shuffle();

        return 
           HomeState(
             StateId: DateTime.now().microsecond.toString(),
              pastYearMovieList: pastYearLists,
              trendingMovieList: trendingLists,
              tenseDramaMovieList: tenseDramaLists,
              southIndianMovieList: southIndianLists,
              trendingTvList: state.trendingTvList,
              isLoading: false,
              hasError: false);
        
      });
      emit(_state1);

   final _state2=   _tvResult.fold((MainFailure failure) {
       return  HomeState(
         StateId: DateTime.now().microsecond.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramaMovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true);
      }, (HotAndNewRespo respo){
 return 
           HomeState(
             StateId: DateTime.now().microsecond.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: state.trendingMovieList,
              tenseDramaMovieList: state.tenseDramaMovieList,
              southIndianMovieList: state.southIndianMovieList,
              trendingTvList: respo.results,
              isLoading: false,
              hasError: false);
      });
      emit(_state2);
    });
  }
}
