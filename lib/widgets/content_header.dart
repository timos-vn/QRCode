import 'package:flutter/material.dart';

import 'package:flutter_netflix_responsive_ui/models/models.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Expanded(child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white60,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),)
            ),
            Container(
              height: 400.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(featuredContent.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(flex: 2,child: Container())
          ],
        ),
        Container(
          height:  300.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfffbb448),
                Colors.transparent
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          top: 40.0,
          child: SizedBox(
            height: 110,
            width: 110.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Colors.white,
              ),
              // padding: EdgeInsets.all(10),
                child: Image.asset('assets/images/logo_timos.png',fit: BoxFit.cover,)),
          ),
        ),
        Positioned(
          bottom: 290.0,
          child: SizedBox(
            // width: 250.0,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Gọi Timos - Ô tô đến tận nhà',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),)),
                SizedBox(height: 20,),
                Center(
                  child: Text('Đặt xe công nghệ - giao hàng nhanh chóng - phủ sóng muôn nơi',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 220,
        //   child: Center(
        //     child: Text('Tải app tại đây',
        //       style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),),
        // ),
        Positioned(
          bottom: 150.0,
          child: Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap:()=>OpenAppstore.launch(androidAppId: "takecare.vn.limousine", iOSAppId: "takecare.vn.limousine"),
                    child: SizedBox(
                        width: 150.0,
                        child: Image.asset('assets/images/app_store.png',fit: BoxFit.cover,)),
                  ),
                  SizedBox(width: 50,),
                  GestureDetector(
                    onTap:()=>OpenAppstore.launch(androidAppId: "takecare.vn.limousine", iOSAppId: "takecare.vn.limousine"),
                    child: SizedBox(
                        width: 150.0,
                        child: Image.asset('assets/images/google_play.png',fit: BoxFit.cover,)),
                  )
                ],
              )),
        ),
        Positioned(
          bottom: 2.0,
          child: Center(
              child: Text('timos.vn',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
    // _videoController.setVolume(100);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.initialized
                ? _videoController.value.aspectRatio
                : 2.344,
            child: _videoController.value.initialized
                ? //VideoPlayer(_videoController)
            Image.asset(
              widget.featuredContent.imageUrl,
              fit: BoxFit.cover,
            )
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController.value.initialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xfffbb448), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Text('Timos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                        wordSpacing: 5.0,
                        letterSpacing: 10.0
                    ),),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                // Row(
                //   children: [
                //     _PlayButton(),
                //     const SizedBox(width: 16.0),
                //     FlatButton.icon(
                //       padding:
                //           const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                //       onPressed: () => print('More Info'),
                //       color: Colors.white,
                //       icon: const Icon(Icons.info_outline, size: 30.0),
                //       label: const Text(
                //         'More Info',
                //         style: TextStyle(
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 20.0),
                //     if (_videoController.value.initialized)
                //       IconButton(
                //         icon: Icon(
                //           _isMuted ? Icons.volume_off : Icons.volume_up,
                //         ),
                //         color: Colors.white,
                //         iconSize: 30.0,
                //         onPressed: () => setState(() {
                //           _isMuted
                //               ? _videoController.setVolume(100)
                //               : _videoController.setVolume(0);
                //           _isMuted = _videoController.value.volume == 0;
                //         }),
                //       ),
                //   ],
                // ),
                Text(
                  'Download ứng dụng tại:',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap:()=>launch('https://apps.apple.com/us/app/timos/id1563546063'),
                      child: SizedBox(
                          width: 150.0,
                          child: Image.asset('assets/images/app_store.png',fit: BoxFit.cover,)),
                    ),
                    SizedBox(width: 50,),
                    GestureDetector(
                      onTap:()=>launch('https://play.google.com/store/apps/details?id=takecare.vn.limousine'),
                      child: SizedBox(
                          width: 150.0,
                          child: Image.asset('assets/images/google_play.png',fit: BoxFit.cover,)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
          : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
      onPressed: () => print('Play'),
      color: Colors.white,
      icon: const Icon(Icons.play_arrow, size: 30.0),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
