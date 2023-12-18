import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/mainfailures/main_failures.dart';
import 'package:netflix_clone/domain/hot_and_new/HotAndNewsService.dart';
import 'package:netflix_clone/domain/hot_and_new/hot_and_new_respo/hot_and_new_respo.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {


    on<LoadDataInCommingSoon>((event, emit) async {

      //loading ui
      emit(const HotAndNewState(
        commingSoonList: [],
        EveryOneIsWatchingList: [],
        isLoading: true,
        hasError: false,
      ));
      final _result = await _hotAndNewService.getHotAndNewMovieData();

   final NewStateComming=   _result.fold((MainFailure failure) {
        return const HotAndNewState(
          commingSoonList: [],
          EveryOneIsWatchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewRespo resp) {
         return  HotAndNewState(
          commingSoonList: resp.results,
          EveryOneIsWatchingList:state.EveryOneIsWatchingList,
          isLoading: false,
          hasError: false,
        );
      }
      
      );
      emit(NewStateComming);
    });

    on<LoadDataInEveryOneWatching>((event, emit) async {
       //loading ui

  

      emit(const HotAndNewState(
        commingSoonList: [],
        EveryOneIsWatchingList: [],
        isLoading: true,
        hasError: false,
      ));
      final _result = await _hotAndNewService.getHotAndNewTVData();

   final NewStateEveryOne=   _result.fold((MainFailure failure) {
        return const HotAndNewState(
          commingSoonList: [],
          EveryOneIsWatchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewRespo resp) {
         return  HotAndNewState(
          commingSoonList: state.commingSoonList,
          EveryOneIsWatchingList:resp.results,
          isLoading: false,
          hasError: false,
        );
      }
      
      );
      emit(NewStateEveryOne);
    });
 
  }
}
