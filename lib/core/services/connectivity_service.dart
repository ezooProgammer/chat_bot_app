// core/services/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection();

  /// Stream يُصدر `true` عند وجود إنترنت، و `false` عند الانقطاع
  Stream<bool> get onStatusChange {
    // 1. راقب تغيّر نوع الاتصال (Wi-Fi / Mobile / None)
    // 2. عند أي تغيير، تحقق فعليًا من الإنترنت
    return _connectivity.onConnectivityChanged.asyncMap((results) async {
      if (results.contains(ConnectivityResult.none)) return false;
      return await _internetChecker.hasInternetAccess;
    }).distinct();
  }

  /// فحص فوري
  Future<bool> get hasConnection async {
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) return false;
    return await _internetChecker.hasInternetAccess;
  }
}
