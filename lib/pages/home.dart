import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("恶搞盒"),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return AppCard(
                  title: '鸡哥',
                  image: '',
                  onTap: () {
                    context.push('/detail/jige');
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset("assets/jige.png"),
          ),
          Text(title),
        ],
      ),
    );
  }
}
