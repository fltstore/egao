import 'package:egao/utils/epath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import '../model/detail.dart';
import '../packages/nil/nil.dart';

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

  playAudio(String id, Datum curr) async {
    var soundPath = spliceSoundPath(id, curr.sound);
    // debugPrint("sound path is: $soundPath");
    player.setAsset(soundPath, preload: false,);
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    Future<EgaoDatabaseDetail> loadData() async {
      var path = spliceMetaDataPath(widget.id);
      String data = await rootBundle.loadString(path);
      EgaoDatabaseDetail detail = egaoDatabaseDetailFromJson(data);
      return detail;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text("语音包详情"),
      ),
      body: FutureBuilder(
          future: loadData(),
          builder: (
            BuildContext context,
            AsyncSnapshot<EgaoDatabaseDetail> snapshot,
          ) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                var data = snapshot.data;
                if (data == null) return nil;
                return _buildWithBody(data);
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }

  Widget _buildWithBody(EgaoDatabaseDetail data) {
    return Column(
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
                    spliceMetaDataLogoPath(data.logo),
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
                        children: [
                          Text(data.name),
                          Builder(builder: (context) {
                            var len = data.data.length;
                            var text = '共$len条声音';
                            return Text(text);
                          }),
                        ],
                      ),
                      Text("简介: ${data.desc}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.data.length,
            itemBuilder: ((context, index) {
              var curr = data.data[index];
              return ListTile(
                onTap: () {
                  playAudio(data.id, curr);
                },
                title: Text(
                  curr.title,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
