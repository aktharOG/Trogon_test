import '../../../exports_main.dart';

final emailRegExp = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);

// Define a function to get the URI for a given endpoint
Uri getUri(String endpoint, [Map<String, dynamic>? queryParameters]) {
  // Use the Uri.http constructor to create a URI with the base URL and the endpoint
  return Uri.https(EnvLoader.get('BASE_URL'), endpoint, queryParameters);
}
