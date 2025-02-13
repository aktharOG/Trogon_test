import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:trogon_test/src/data/models/module_model.dart';
import 'package:trogon_test/src/data/models/subject_model.dart';

import '../../../exports_main.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_constants.dart';
import '../../core/utils/error_handler.dart';

abstract class ModuleDataSource {
  Future<Either<Failure, List<ModuleModel>>> onFetchModuleList(int subjectID);
}

@LazySingleton(as: ModuleDataSource)
class ModuleDataSourceImpl implements ModuleDataSource {
  final AppUrls _appUrls;

  ModuleDataSourceImpl({
    required AppUrls appUrls,
  })  : _appUrls = appUrls;

  @override
  Future<Either<Failure, List<ModuleModel>>> onFetchModuleList(
    int subjectID
  ) async {
    final client = http.Client();
    log("api : ${_appUrls.modulesAPI}");

    try {
      final url = getUri(_appUrls.modulesAPI);

      final uri = Uri.parse(url.toString()).replace(
        queryParameters: {
          'subject_id': subjectID.toString(),
        },
      );
      log("url : $uri");

      // Adding a timeout to the request
      final response = await client.get(
        uri,
       
      ).timeout(
        const Duration(seconds: 10),
      ); // Adjust the duration as needed

      if (response.statusCode == 200) {
        print("res : ${response.body}");
        final data = jsonDecode(response.body);

        return Right(moduleModelFromJson(jsonEncode(data)));
      } else {
        log("error on data source : ");

        // Handle other status codes (e.g., 404, 500)
        return Left(
          handleStatusCode(
            response.statusCode,
            '${jsonDecode(response.body)['message']}',
          ),
        );
      }
    } catch (e) {
      log("on error : $e");
      return Left(handleException(e));
    } finally {
      log('Closing http client ', name: 'AuthDataSourceImpl');
      client.close();
    }
  }
}
