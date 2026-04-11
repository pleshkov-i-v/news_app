import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({this.bottomNavIndex = 0});

  final int bottomNavIndex;

  HomeState copyWith({int? bottomNavIndex}) {
    return HomeState(bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex);
  }

  @override
  List<Object?> get props => [bottomNavIndex];
}
