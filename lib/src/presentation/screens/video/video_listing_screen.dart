// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:trogon_test/exports_main.dart';
import 'package:trogon_test/src/core/constants/app_images.dart';
import 'package:trogon_test/src/core/utils/app_colors.dart';
import 'package:trogon_test/src/data/models/module_model.dart';
import 'package:trogon_test/src/presentation/provider/video_provider.dart';
import 'package:trogon_test/src/presentation/widgets/custom_text.dart';

import '../../../core/utils/app_loading_widgets.dart';
import '../../widgets/custom_image_widget.dart';

class VideoListingScreen extends StatefulWidget {
  final ModuleModel model;
  const VideoListingScreen({super.key, required this.model});

  @override
  State<VideoListingScreen> createState() => _VideoListingScreenState();
}

class _VideoListingScreenState extends State<VideoListingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<VideoProvider>().onFetchVideosList(widget.model.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          name: widget.model.title,
          fontsize: 20,
        ),
      ),
      body: Consumer<VideoProvider>(builder: (context, videoPro, w) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: videoPro.isLoading
                    ? AppLoadingDS.folderItemsLoadingShimmer(
                    
                    )
                    : GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: videoPro.videosList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 3.5, crossAxisCount: 3),
            itemBuilder: (context, index) {
              final data = videoPro.videosList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      navigator?.pushNamed(RouteName.videoScreen,
                          arguments: data);
                      log("video : ${data.getVideoId()}");
                    },
                    child: Card(
                      child: Hero(
                        tag: data.title,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImageWidget(
                                  imagePath: AppImages.videoThumb,
                                  boxFit: BoxFit.cover,
                                )),
                                AspectRatio(
                                  aspectRatio: 3/2,
                                  child: Container(
                                    
                                   decoration: BoxDecoration(
                                     color: Colors.black.withOpacity(0.5),
                                     borderRadius: BorderRadius.circular(10)
                                   ),
                                  ),
                                ),
                            CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    name: data.title,
                    textAlign: TextAlign.center,
                    fontweight: FontWeight.bold,
                  ),
                  //CustomText(name: data.description),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
