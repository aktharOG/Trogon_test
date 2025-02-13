import 'dart:developer';

import 'package:trogon_test/exports_main.dart';
import 'package:trogon_test/src/data/models/video_model.dart';
import 'package:trogon_test/src/data/repository/videos_repo.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class VideoProvider extends ChangeNotifier {
  final VideosRepo _videosRepo;
  VideoProvider({required VideosRepo videosRepo}) : _videosRepo = videosRepo;

  // all api called data lists

  List<VideoModel> _videosList = [];
  List<VideoModel> get videosList => _videosList;

  // set data to list

  set onSetData(List<VideoModel> data) {
    _videosList = data;
    log("total modules : ${_videosList.length}");
    notifyListeners();
  }

  // api calls

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setDashboardLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  set setErrorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  bool _isError = false;
  bool get isError => _isError;

  set setIsError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  set setIsSuccess(bool value) {
    _isSuccess = value;
    notifyListeners();
  }

  Future<void> onFetchVideosList(int moduleID) async {
    setDashboardLoading = true;

    final homeData = await _videosRepo.onFetchVideosList(moduleID);
    homeData.fold((l) {
      log("Error from provider------>: ${l.message}");
      setErrorMessage = l.message;
      setIsError = true;
      setIsSuccess = false;
      setDashboardLoading = false;
    }, (r) {
      setIsError = false;
      setIsSuccess = true;
      setDashboardLoading = false;
      onSetData = r;
    });
  }

}
