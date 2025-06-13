import 'dart:math';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';

@injectable
class NetworkServices {
  late Dio dio;
  NetworkServices() {
    init();
  }
  void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstant.baseUrl,
        validateStatus: (status) {
          if (status != null) {
            if (status < 300) {
              return true;
            } else if (status == 401) {
              return true;
            } else if(status == 400) {
              return true;
            }
            return false;
          } else {
            return false;
          }
        },
      ),
    );
  }
}
