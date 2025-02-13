
import 'package:dartz/dartz.dart';
import 'package:trogon_test/src/data/data_source/module_data_source.dart';
import 'package:trogon_test/src/data/models/module_model.dart';

import '../../../exports_main.dart';
import '../../core/utils/error_handler.dart';

abstract class ModuleRepo {
  Future<Either<Failure, List<ModuleModel>>> onFetchModuleList(int subjectID);
}
@LazySingleton(as: ModuleRepo)
class ModuleRepoImpl implements ModuleRepo {
  final ModuleDataSource _moduleDataSource;
  ModuleRepoImpl({required ModuleDataSource moduleDataSource})
      : _moduleDataSource = moduleDataSource;

  @override
  Future<Either<Failure, List<ModuleModel>>> onFetchModuleList(int subjectID) {
    return _moduleDataSource.onFetchModuleList(subjectID);
  }
}
