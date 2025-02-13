
import 'package:dartz/dartz.dart';
import 'package:trogon_test/src/data/data_source/subjects_data_source.dart';
import 'package:trogon_test/src/data/models/subject_model.dart';

import '../../../exports_main.dart';
import '../../core/utils/error_handler.dart';

abstract class SubjectsRepo {
  Future<Either<Failure, List<SubjectModel>>> onFetchSubjectsList();
}
@LazySingleton(as: SubjectsRepo)
class SubjectsRepoImpl implements SubjectsRepo {
  final SubjectsDataSource _subjectsDataSource;
  SubjectsRepoImpl({required SubjectsDataSource subjectsDataSource})
      : _subjectsDataSource = subjectsDataSource;

  @override
  Future<Either<Failure, List<SubjectModel>>> onFetchSubjectsList() {
    return _subjectsDataSource.onFetchSubjectsList();
  }
}
