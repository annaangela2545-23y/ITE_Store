class Config {
  //static instance
  static final _instance = Config._internal();

  //private constructor
  Config._internal();
  // static/factory method
  factory Config() => _instance;

  String? _runtimeEnv;

  String get env =>
      _runtimeEnv ?? const String.fromEnvironment('ENV', defaultValue: 'DEV');

  set env(String value) {
    _runtimeEnv = value.trim().toUpperCase();
  }

  String get apiBaseUrl {
    switch (env.toUpperCase()) {
      case 'PROD':
        return 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/prod/';
      case 'UAT':
        return 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/uat/';
      case 'DEMO':
        return 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/demo/';
      default:
        return 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/dev/';
    }
  }
}
