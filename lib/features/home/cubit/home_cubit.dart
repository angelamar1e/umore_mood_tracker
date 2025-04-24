import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  /* TODO: get currentWeekRecord -> utils = get mood entries for current week (get latest record added per day), 
  loop thru each to save to another list, transform timestamps (shortened day of week, date), get mood image for each day */
}
