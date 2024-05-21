enum Environment { live, test }

enum ProcessState { loading, done, idle, failed }

enum AuthType { login, verify, register }

enum AuthAction { SIGNUP, LOGIN, VERIFY }

enum InputFieldStatus { EMPTY, VALIDATED, INVALIDATED }

enum CropType { square, horiz, vertz }

enum GResultType { All, Videos, News, Images, Maps, Shopping, Books, Flights }

extension GResultTypeToString on GResultType {
  String get string => this
      .toString()
      .split('.')
      .last; //sample: GResultType.Videos => => "GresultType, Videos" [GresultType, Videos] => Videos;
}
