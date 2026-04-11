import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void setBottomNavIndex(int index) {
    if (index == state.bottomNavIndex) return;
    emit(state.copyWith(bottomNavIndex: index));
  }
}
