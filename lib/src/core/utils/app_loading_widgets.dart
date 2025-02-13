import 'package:shimmer/shimmer.dart';

import '../../../exports_main.dart';

class AppLoadingDS {
  static Widget folderItemsLoadingShimmer() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const VerticalItemShimmerView(),
      ),
    );
  }

   static Widget gridItemsLoadingShimmer() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const GridItemShimmerView(),
      ),
    );
  }
}

class VerticalItemShimmerView extends StatelessWidget {
  final double height;
  final double width;
  const VerticalItemShimmerView({
    super.key,
    this.height = 69,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}

// grid

class GridItemShimmerView extends StatelessWidget {
  final double height;
  final double width;
  const GridItemShimmerView({
    super.key,
    this.height = 69,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            height: height,
            width: width,
          ),
        );
      },
    );
  }
}
