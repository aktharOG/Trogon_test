import 'package:trogon_test/src/data/data_source/module_data_source.dart';
import 'package:trogon_test/src/data/data_source/subjects_data_source.dart';
import 'package:trogon_test/src/data/data_source/videos_data_source.dart';
import 'package:trogon_test/src/data/models/module_model.dart';
import 'package:trogon_test/src/data/models/subject_model.dart';
import 'package:trogon_test/src/data/models/video_model.dart';
import 'package:trogon_test/src/data/repository/module_repo.dart';
import 'package:trogon_test/src/data/repository/subjects_repo.dart';
import 'package:trogon_test/src/data/repository/videos_repo.dart';
import 'package:trogon_test/src/presentation/provider/home_provider.dart';
import 'package:trogon_test/src/presentation/provider/module_provider.dart';
import 'package:trogon_test/src/presentation/provider/video_provider.dart';
import 'package:trogon_test/src/presentation/screens/home/home_screen.dart';
import 'package:trogon_test/src/presentation/screens/module/module_screen.dart';
import 'package:trogon_test/src/presentation/screens/video/video_listing_screen.dart';
import 'package:trogon_test/src/presentation/screens/video/video_screen.dart';

import 'exports_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  const String environment =
      String.fromEnvironment('ENV', defaultValue: 'production');
  await EnvLoader.load(fileName: '.env.$environment');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(
              subjectsRepo: SubjectsRepoImpl(
                  subjectsDataSource: SubjectsDataSourceImpl(
            appUrls: getIt<AppUrls>(),
          ))),
        ),
        ChangeNotifierProvider(
          create: (context) => ModuleProvider(
              moduleRepo: ModuleRepoImpl(
                  moduleDataSource: ModuleDataSourceImpl(
            appUrls: getIt<AppUrls>(),
          ))),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(
              videosRepo: VideosRepoImpl(
                  videosDataSource: VideosDataSourceImpl(
            appUrls: getIt<AppUrls>(),
          ))),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white, surfaceTintColor: Colors.white),
            fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.home,
        navigatorKey: navKey,
        scaffoldMessengerKey: scaffoldKey,
        onGenerateRoute: (settings) {
          final name = settings.name;

          switch (name) {
            case RouteName.home:
              return MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              );
            case RouteName.moduleScreen:
              final args = settings.arguments as SubjectModel;

              return MaterialPageRoute(
                builder: (context) {
                  return ModuleScreen(
                    subjectModel: args,
                  );
                },
              );

            case RouteName.videoListingScreen:
              final args = settings.arguments as ModuleModel;

              return MaterialPageRoute(
                builder: (context) {
                  return VideoListingScreen(
                    model: args,
                  );
                },
              );
            case RouteName.videoScreen:
              final args = settings.arguments as VideoModel;

              return MaterialPageRoute(
                builder: (context) {
                  return VideoScreen(
                    model: args,
                  );
                },
              );

            default:
              return null;
          }
        },
      ),
    );
  }
}
