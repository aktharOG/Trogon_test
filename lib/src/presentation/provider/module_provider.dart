import 'dart:developer';

import 'package:trogon_test/exports_main.dart';
import 'package:trogon_test/src/data/models/module_model.dart';
import 'package:trogon_test/src/data/repository/module_repo.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class ModuleProvider extends ChangeNotifier {
  final ModuleRepo _moduleRepo;
  ModuleProvider({required ModuleRepo moduleRepo}) : _moduleRepo = moduleRepo;

  // all api called data lists

  List<ModuleModel> _moduleList = [];
  List<ModuleModel> get moduleList => _moduleList;

  // set data to list

  set onSetData(List<ModuleModel> data) {
    _moduleList = data;
    log("total modules : ${_moduleList.length}");
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

  Future<void> onFetchModuleList(int subjectID) async {
    setDashboardLoading = true;

    final homeData = await _moduleRepo.onFetchModuleList(subjectID);
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
