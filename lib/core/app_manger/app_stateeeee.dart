import 'package:equatable/equatable.dart';

class AppManagerState extends Equatable {
  final bool isLoggedIn;
  final int bottomNavBarIndex;
  final String currentLanguage;
  const AppManagerState({
    this.isLoggedIn = false,
    this.bottomNavBarIndex = 0,
    this.currentLanguage = 'en',
  });
  factory AppManagerState.initial() {
    return const AppManagerState(
      isLoggedIn: false,
      bottomNavBarIndex: 0,
      currentLanguage: 'en',
    );
  }
  AppManagerState copyWith({
    bool? isLoggedIn,
    int? bottomNavBarIndex,
    String? currentLanguage,
  }) {
    return AppManagerState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      bottomNavBarIndex: bottomNavBarIndex ?? this.bottomNavBarIndex,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }

  @override
  List<Object?> get props => [isLoggedIn, bottomNavBarIndex, currentLanguage];
}
