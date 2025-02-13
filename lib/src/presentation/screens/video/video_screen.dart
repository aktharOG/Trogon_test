import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trogon_test/src/data/models/video_model.dart';
import 'package:trogon_test/src/presentation/widgets/custom_text.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VideoScreen extends StatefulWidget {
  final VideoModel model;
  const VideoScreen({super.key, required this.model});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Orientation orientation = Orientation.portrait;

  String? youTubeVideoId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed|live)?)\/|\S*?[?&]v=)|youtu\.be\/|youtube\.com\/live\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    final Match? match = regExp.firstMatch(url);
    return match?.group(1); // Returns the video ID or null if not found
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      ); // to only hide the status bar
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
         SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.portraitUp,
                                          ]);
      },
      child: Scaffold(
        
        appBar: AppBar(
          title: CustomText(
            name: widget.model.title,
            fontsize: 20,
            fontweight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: widget.model.videoType == VideoType.YOU_TUBE
                    ?
                    // youtube video view without yt brandings
      
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: orientation == Orientation.portrait
                              ? BorderRadius.circular(0)
                              : BorderRadius.zero,
                          child: AspectRatio(
                            aspectRatio: orientation == Orientation.landscape
                                ? MediaQuery.of(context).size.aspectRatio
                                : 16 / 9,
                            child: Container(
                              color: Colors.black,
                              child: AndroidView(
                                viewType: 'native_video_view',
                                creationParams: {
                                  'url':
                                      'https://www.youtube.com/embed/${youTubeVideoId(widget.model.videoUrl.toString())}?rel=0&autoplay=1',
                                },
                                creationParamsCodec:
                                    const StandardMessageCodec(),
                              ),
                            ),
                          ),
                        ),
                        if (orientation == Orientation.portrait)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Opacity(
                                    opacity: 0,
                                    child: Container(
                                      height: 50,
                                      width: 70,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 22,
                                  child: InkWell(
                                    onTap: () {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.landscapeRight,
                                        DeviceOrientation.landscapeLeft,
                                      ]);
                                    },
                                    child: const Opacity(
                                      opacity: 0,
                                      child: Icon(
                                        Icons.fullscreen,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (orientation == Orientation.landscape)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Opacity(
                                    opacity: 0,
                                    child: Container(
                                      height: 100,
                                      width: 70,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 21,
                                  child: InkWell(
                                    onTap: () {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                      ]);
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.manual);
                                    },
                                    child: const Opacity(
                                      opacity: 0,
                                      child: Icon(
                                        Icons.fullscreen,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
      
                    // vimeo plyer
      
                    :
                    VimeoPlayer(videoId: widget.model.getVideoId())),
                    
                    // VimeoVideoPlayer(videoId: widget.model.getVideoId())),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomText(
                name: widget.model.description,
                fontsize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
