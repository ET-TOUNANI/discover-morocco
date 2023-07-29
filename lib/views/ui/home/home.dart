import 'package:badges/badges.dart' as b;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:discover_morocco/views/ui/chat/Chat.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/item.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:discover_morocco/views/ui/navigation/menu.dart';
import 'package:discover_morocco/views/ui/notification/notification.dart';
import 'package:discover_morocco/views/ui/reels/tiktok_video_view.dart';
import 'package:discover_morocco/views/widgets/circle_button.dart';

import 'bookmarked/bookmarked.dart';
import 'explore/explore.dart';
import 'search/search.dart';

class MainView extends StatefulWidget {
  static const routeName = '/home';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  //late AppLocalizations _localizations;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    // _localizations = AppLocalizations.of(context)!;
    _theme = Theme.of(context);

    super.didChangeDependencies();
  }

  void onNotificationPressed() {
    Navigator.of(context).pushNamed(NotificationView.routeName);
  }

  void onButtomNavigatorExplorePressed() {
    Navigator.of(context).pushNamed(TiktokVideoView.routeName); //ExploreView
  }

  void onProfilePicturePressed() {
    Navigator.of(context).pushNamed(NavigationMenu.routeName);
  }

  void onChatBotPressed() {
    Navigator.of(context).pushNamed(Chat.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/logo_black.svg',
          height: 36,
          semanticsLabel: 'Discover Morocco',
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: Ink.image(
                image: const AssetImage('assets/mock/profile.png'),
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: onProfilePicturePressed,
                ),
              ),
            ),
          ),
        ],
        leading: CircleIconButton(
          icon: b.Badge(
            badgeContent: Text(
              '2',
              style: _theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            elevation: 0,
            position: b.BadgePosition.topEnd(end: -4, top: -4),
            child: const Icon(
              Icons.notifications_rounded,
              size: 30.0,
            ),
          ),
          onTap: onNotificationPressed,
          padding: const EdgeInsetsDirectional.only(start: 4),
        ),
        elevation: 0,
        backgroundColor: _theme.canvasColor,
      ),
      body: DefaultTabController(
        length: 3,
        child: FloatingBottomNavbar(
          color: _theme.primaryColor,
          unselectedColor: Colors.white,
          start: 30,
          end: 2,
          actions: [
            FloatingBottomNavbarAction(
              onTap: onButtomNavigatorExplorePressed,
              child: const Icon(Icons.explore),
            ),
          ],
          tabs: const [
            FloatingBottomNavbarItem(
              icon: Icons.home_rounded,
              text: "Home",
            ),
            FloatingBottomNavbarItem(
              icon: Icons.bookmark,
              text: "Bookmarked",
            ),
            FloatingBottomNavbarItem(
              icon: Icons.search,
              text: "Search",
            ),
          ],
          child: const TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            physics: BouncingScrollPhysics(),
            children: [
              ExploreView(),
              BookmarkView(),
              SearchView(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onChatBotPressed,
        child: Lottie.asset('assets/mock/typing.json'),
      ),
    );
  }
}