import 'package:flutter/material.dart';
import 'package:trogon_test/src/presentation/widgets/custom_text.dart';

import '../../../../../exports_main.dart';
import '../../../../core/utils/app_loading_widgets.dart';
import '../../../provider/home_provider.dart';
import '../../../widgets/custom_image_widget.dart';

class SubjectsTab extends StatelessWidget {
  const SubjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          name: "All Subjects",
          fontsize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Consumer<HomeProvider>(builder: (context, homePro, w) {
          return homePro.isDashboardLoading
              ? AppLoadingDS.gridItemsLoadingShimmer()
              : GridView.builder(
                  itemCount: homePro.subjectsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 3.5, crossAxisCount: 3),
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
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomImageWidget(
                                  imagePath: data.image,
                                  boxFit: BoxFit.cover,
                                )),
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
      ),
    );
  }
}
