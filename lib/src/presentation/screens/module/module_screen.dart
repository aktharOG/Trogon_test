import 'package:trogon_test/exports_main.dart';
import 'package:trogon_test/src/core/utils/app_loading_widgets.dart';
import 'package:trogon_test/src/data/models/subject_model.dart';
import 'package:trogon_test/src/presentation/provider/module_provider.dart';
import 'package:trogon_test/src/presentation/widgets/custom_image_widget.dart';
import 'package:trogon_test/src/presentation/widgets/custom_text.dart';

class ModuleScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  const ModuleScreen({super.key, required this.subjectModel});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context
            .read<ModuleProvider>()
            .onFetchModuleList(widget.subjectModel.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          name: widget.subjectModel.title,
          fontsize: 20,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.subjectModel.image,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomImageWidget(
                      imagePath: widget.subjectModel.image,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                name: widget.subjectModel.description,
                fontsize: 16,
              ),
              SizedBox(
                height: 15,
              ),
              CustomText(
                name: "Modules",
                fontsize: 20,
              ),
              SizedBox(
                height: 15,
              ),
              Consumer<ModuleProvider>(builder: (context, modulePro, w) {
                return modulePro.isLoading
                    ? AppLoadingDS.folderItemsLoadingShimmer()
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: modulePro.moduleList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = modulePro.moduleList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4, top: 4),
                            child: ListTile(
                              onTap: () {
                                navigator?.pushNamed(
                                    RouteName.videoListingScreen,
                                    arguments: data);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              tileColor: const Color.fromARGB(255, 28, 58, 65),
                              title: CustomText(
                                name: data.title,
                                color: Colors.white,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                              leading: CustomText(
                                name: "${index + 1}.",
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
