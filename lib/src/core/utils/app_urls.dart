import 'package:injectable/injectable.dart';

abstract class AppUrls {
  String get baseUrl;

  String get subjectsAPI;

  String get modulesAPI;

  String get videosAPI;

}

@LazySingleton(as: AppUrls)
class AppUrlsImpl implements AppUrls {

  @override
  String get baseUrl => 'https://trogon.info/interview/php/';


  String get basePath => '/interview/php/api/';

  @override
  String get subjectsAPI => '$basePath/subjects.php';

  @override
  String get modulesAPI => '$basePath/modules.php';

  @override
  String get videosAPI => '$basePath/videos.php';
}
