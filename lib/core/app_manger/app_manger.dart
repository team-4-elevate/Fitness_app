// import 'package:fitness_app/core/app_local_storage/app_local_storage.dart';
// import 'package:fitness_app/core/app_manger/app_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';

// @singleton
// class AppManger extends Cubit<AppManagerState> {
//   AppManger(this._localStorage) : super(AppManagerState.initial());
//   final AppSecureStorage _localStorage;
//   Future<void> getUserLoggedInState() async {
//     final token = await _localStorage.getToken();
//     final rememberMe = await _localStorage.getRememberMe();
//     final language = await _localStorage.getLanguage() ?? 'en';

//     emit(
//       state.copyWith(
//         isLoggedIn: token != null && rememberMe == true,
//         currentLanguage: language,
//       ),
//     );
//   }

//   void changeBottomNavBar(int newIndex) {
//     emit(state.copyWith(bottomNavBarIndex: newIndex));
//   }

//   Future<void> changeLanguage(String languageCode) async {
//     await _localStorage.setLanguage(languageCode);
//     emit(state.copyWith(currentLanguage: languageCode));
//   }
// }
