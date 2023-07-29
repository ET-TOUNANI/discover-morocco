import 'dart:math';

import 'package:flutter/material.dart';
import 'package:discover_morocco/business_logic/models/models/tiktok.dart';
import 'package:discover_morocco/views/ui/reels/page_view.dart';
import 'package:discover_morocco/views/utils/constants.dart';

class TiktokVideoView extends StatefulWidget {
  static const routeName = 'explore';
  const TiktokVideoView({super.key});

  @override
  State<TiktokVideoView> createState() => _TiktokVideoViewState();
}

class _TiktokVideoViewState extends State<TiktokVideoView> {
  final PageController _pageController = PageController();
  //late AppLocalizations _localizations;
  late ThemeData _theme;

  late List<Map<String, String>> datasource;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //_localizations = AppLocalizations.of(context)!;
    _theme = Theme.of(context);

    final arg = ModalRoute.of(context)!.settings.arguments;

    datasource = List.from(snapList);

    if (arg != null) {
      final item = datasource.where((e) => e['id'] == arg).first;
      datasource.remove(item);
      datasource.insert(0, item);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: _theme.iconTheme.copyWith(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: datasource
            .map(
              (e) => TiktokPageView(
                TiktokModel(
                  id: e['id']!,
                  title: e['title']!,
                  imageUrl: e['imageUrl']!,
                  video: e['video']!,
                  description: e['description'],
                  likes: random.nextInt(70) + 10,
                  comments: 5000,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
