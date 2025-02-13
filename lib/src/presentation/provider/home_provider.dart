import 'dart:developer';

import 'package:trogon_test/exports_main.dart';
import 'package:trogon_test/src/core/constants/app_images.dart';
import 'package:trogon_test/src/data/models/subject_model.dart';
import 'package:trogon_test/src/data/repository/subjects_repo.dart';
import 'package:url_launcher/url_launcher.dart';
@lazySingleton
class HomeProvider extends ChangeNotifier{
 final SubjectsRepo _subjectsRepo;
   HomeProvider ({
    required SubjectsRepo subjectsRepo
   }):_subjectsRepo = subjectsRepo{
    onFetchSubjectsList();
   }


  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


  void updateIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }



  // home banner list 

  List bannerList = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3
  ];

  // all api called data lists

  List<SubjectModel> _subjectsList = [];
  List<SubjectModel> get subjectsList => _subjectsList;


  // set data to list 

  set onSetData(List<SubjectModel> data){
    _subjectsList = data;
    log("total subjetcs : ${_subjectsList.length}");
    notifyListeners();
  }

 // api calls

 bool _isDashboardLoading = false;
  bool get isDashboardLoading => _isDashboardLoading;

  set setDashboardLoading(bool value) {
    _isDashboardLoading = value;
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


 Future<void> onFetchSubjectsList() async {
      setDashboardLoading = true;
    
    final homeData = await _subjectsRepo.onFetchSubjectsList();
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



  // open whatsapp chat
  Future<bool> onOpenWhatsApp(phone, message) async {
    bool result = false;
    Uri uri =
        Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        result = true;
        notifyListeners();
        return result;
      } else {
        print("error : whats app not installed");
        result = false;
        notifyListeners();
      }
      return result;
    } catch (e) {
      print("errro : $e");
      return result;
    }
  }



}