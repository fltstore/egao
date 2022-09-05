import 'package:egao/utils/epath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../model/pack.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Future<List<EgaoDatabasePack>> loadData() async {
    var jsonStr = await rootBundle.loadString('assets/database/pack.json');
    List<EgaoDatabasePack> packs = egaoDatabasePackFromJson(jsonStr);
    return packs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("恶搞盒"),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: loadData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<EgaoDatabasePack>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _buildWithBody(snapshot.data ?? []);
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Widget _buildWithBody(List<EgaoDatabasePack> data) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.8),
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var curr = data[index];
              return AppCard(
                title: curr.name,
                image: spliceMetaDataLogoPath(curr.logo),
                onTap: () {
                  context.push('/detail/${curr.id}');
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.title,
    required this.image,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
