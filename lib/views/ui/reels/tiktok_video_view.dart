import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:discover_morocco/business_logic/models/models/enums/PubState.dart';
import 'package:discover_morocco/views/ui/reels/page_view.dart';
import 'package:flutter/material.dart';

import '../../../business_logic/models/authentication/models/user.dart';
import '../../../business_logic/models/models/publication.dart';

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

    datasource = List.empty();//List.from(snapList);

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
                Publication(
                    id: e['id']!,
                    title: e['title']!,
                    imageUrl: e['imageUrl']!,
                    video: e['video']!,
                    description: e['description'],
                    likes: e["likes"]! as int,
                    comments: e["comments"]! as int,
                    state: e['state']! as PubState,
                    user: e['user']! as UserModel,
                    destination: e['destination']! as DestinationModel,

                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
