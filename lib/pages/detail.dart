import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DetailPageView extends StatefulWidget {
  const DetailPageView({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<DetailPageView> createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  final player = AudioPlayer();

  playAudio() async {
    // debugPrint("try set assets");
    player.setAsset('assets/jige.mp3');
    await player.play();
    // debugPrint("played");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text("语音包详情"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/jige.png',
                      width: 88,
                      height: 88,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    height: 88,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('鸡哥'),
                            Text('共24条声音'),
                          ],
                        ),
                        const Text("简介: 练习时长两年半的鸡"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 120,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () {
                    playAudio();
                  },
                  title: const Text(
                    '你干嘛哎呦',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
