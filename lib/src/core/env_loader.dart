import 'package:flutter/services.dart' show rootBundle;

class EnvLoader {
  static final Map<String, String> _env = {};

  static Future<void> load({String fileName = ".env"}) async {
    final contents = await rootBundle.loadString(fileName);
    final lines = contents.split('\n');

    for (var line in lines) {
      if (line.trim().isEmpty || line.startsWith('#')) continue;
      final parts = line.split('=');
      if (parts.length == 2) {
        _env[parts[0].trim()] = parts[1].trim();
      }
    }
  }

  static String get(String key, {String defaultValue = ''}) {
    return _env[key] ?? defaultValue;
  }
}
