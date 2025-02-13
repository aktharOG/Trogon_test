import 'package:flutter/material.dart';
import 'package:trogon_test/exports_main.dart';
import 'package:trogon_test/src/core/utils/app_loading_widgets.dart';
import 'package:trogon_test/src/presentation/provider/home_provider.dart';
import 'package:trogon_test/src/presentation/screens/home/widgets/animated_whatsapp_button.dart';
import 'package:trogon_test/src/presentation/widgets/custom_text.dart';

import '../../../widgets/custom_image_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: WhatsAppButton(),
      ),
      appBar: AppBar(
        title: const CustomText(
          name: "Welcome Akthar !",
          fontsize: 20,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BannerVIew(),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: CustomText(
              name: "Subjects",
              fontsize: 20,
            ),
          ),
          Expanded(
            child: Consumer<HomeProvider>(builder: (context, homePro, w) {
              return homePro.isDashboardLoading?AppLoadingDS.gridItemsLoadingShimmer(): GridView.builder(
                itemCount: homePro.subjectsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3/3.5,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  final data = homePro.subjectsList[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          navigator?.pushNamed(RouteName.moduleScreen,
                              arguments: data);
                        },
                        child: Card(
                          child: Hero(
                            tag:data.image,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImageWidget(imagePath: data.image,
                                boxFit: BoxFit.cover,
                                )),
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
              );
            }),
          )
        ],
      ),
    );
  }
}

class BannerVIew extends StatelessWidget {
  const BannerVIew({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homePro, w) {
      return SizedBox(
      
        height: 200,
        child: CarouselView(
          itemSnapping: true,
          controller: CarouselController(
            initialItem: homePro.currentIndex,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          itemExtent: 400,
          children: List.generate(homePro.bannerList.length, (index) {
            return Image.asset(homePro.bannerList[index],
            fit: BoxFit.cover,
            );
          }),
        ),
      );
    });
  }
}
