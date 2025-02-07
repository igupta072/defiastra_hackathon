import 'package:okto_sdk/okto_flutter_sdk.dart';

class AppBloc {

  static final AppBloc _singleton = AppBloc._internal();

  factory AppBloc() {
    return _singleton;
  }

  AppBloc._internal();

  Future<bool> isLoggedIn() async {
    try {
      final authToken = await OktoSdk().getAuthToken();
      return authToken?.isNotEmpty == true;
    } catch (e) {
      return false;
    }
  }

}