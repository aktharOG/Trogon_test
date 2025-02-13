import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:trogon_test/src/data/models/subject_model.dart';

import '../../../exports_main.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_constants.dart';
import '../../core/utils/error_handler.dart';

abstract class SubjectsDataSource {
  Future<Either<Failure, List<SubjectModel>>> onFetchSubjectsList();
}

@LazySingleton(as: SubjectsDataSource)
class SubjectsDataSourceImpl implements SubjectsDataSource {
  final AppUrls _appUrls;

  SubjectsDataSourceImpl({
    required AppUrls appUrls,
  })  : _appUrls = appUrls;

  @override
  Future<Either<Failure, List<SubjectModel>>> onFetchSubjectsList(

  ) async {
    final client = http.Client();
    log("api : ${_appUrls.subjectsAPI}");

    try {
      final url = getUri(_appUrls.subjectsAPI);

      final uri = Uri.parse(url.toString()).replace(
        // queryParameters: {
        //   'examid': examId.toString(),
        // },
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

        return Right(subjectModelFromJson(jsonEncode(data)));
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
