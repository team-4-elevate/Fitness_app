import 'dart:developer' as dev;

import 'package:fitness_app/core/base_states/app_states.dart';

class AppLogger {
  static void logState(String bloc, Object oldState, Object newState) {
    dev.log(
      '\n[$bloc] 🔄 STATE CHANGE\n'
      '            ➡️ FROM: ${_formatState(oldState)}\n'
      '            ➡️ TO: ${_formatState(newState)}',
      name: bloc,
    );
  }

  static String _formatState(Object state) {
    if (state is SuccessState) {
      final list = _extractListFromState(state);
      if (list != null) {
        return '$state (${list.length} items)';
      }
    }

    return state.toString();
  }

  static List<dynamic>? _extractListFromState(Object state) {
    try {
      if (state is SuccessState && state.data is List) {
        return state.data as List;
      }

      return null;
    } catch (e) {
      dev.log('++++++++onError -- AppLogger, $e');
      return null;
    }
  }
}
