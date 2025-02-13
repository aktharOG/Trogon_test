// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../exports_main.dart' as _i753;
import '../../data/data_source/module_data_source.dart' as _i816;
import '../../data/data_source/subjects_data_source.dart' as _i1045;
import '../../data/repository/subjects_repo.dart' as _i855;
import '../../presentation/provider/home_provider.dart' as _i821;
import '../utils/app_urls.dart' as _i1060;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i1060.AppUrls>(() => _i1060.AppUrlsImpl());
    gh.lazySingleton<_i816.ModuleDataSource>(
        () => _i816.ModuleDataSourceImpl(appUrls: gh<_i753.AppUrls>()));
    gh.lazySingleton<_i1045.SubjectsDataSource>(
        () => _i1045.SubjectsDataSourceImpl(appUrls: gh<_i753.AppUrls>()));
    gh.lazySingleton<_i855.SubjectsRepo>(() => _i855.SubjectsRepoImpl(
        subjectsDataSource: gh<_i1045.SubjectsDataSource>()));
    gh.lazySingleton<_i821.HomeProvider>(
        () => _i821.HomeProvider(subjectsRepo: gh<_i855.SubjectsRepo>()));
    return this;
  }
}
