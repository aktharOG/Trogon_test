
import 'package:dartz/dartz.dart';
import 'package:trogon_test/src/data/data_source/videos_data_source.dart';
import 'package:trogon_test/src/data/models/video_model.dart';

import '../../../exports_main.dart';
import '../../core/utils/error_handler.dart';

abstract class VideosRepo {
  Future<Either<Failure, List<VideoModel>>> onFetchVideosList(int moduleID);
}
@LazySingleton(as: VideosRepo)
class VideosRepoImpl implements VideosRepo {
  final VideosDataSource _videosDataSource;
  VideosRepoImpl({required VideosDataSource videosDataSource})
      : _videosDataSource = videosDataSource;

  @override
  Future<Either<Failure, List<VideoModel>>> onFetchVideosList(int moduleID) {
    return _videosDataSource.onFetchVideosList(moduleID);
  }
}
