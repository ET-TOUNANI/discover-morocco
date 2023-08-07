import 'package:discover_morocco/views/ui/admin/view/Dashboard.dart';
import 'package:discover_morocco/views/ui/chat/Chat.dart';
import 'package:discover_morocco/views/ui/home/widgets/appBarProfile.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/item.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:discover_morocco/views/widgets/circle_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../business_logic/services/Auth_service.dart';
import '../publication/view/list_Publication.dart';
import 'explore/explore.dart';
import 'plan/trip.dart';


class MainView extends StatefulWidget {
  static const routeName = '/home';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  late ThemeData _theme;

  bool idAdmin = false;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    checkUserType();
    super.didChangeDependencies();
  }

  void onNotificationPressed() {
    //  Navigator.of(context).pushNamed(NotificationView.routeName);
  }

  void checkUserType() async {
    idAdmin = await context.read<AuthenticationRepository>().isAdmin();
    setState(() {});
  }

  void onButtomNavigatorExplorePressed() {
    //Navigator.of(context).pushNamed(TiktokVideoView.routeName); //ExploreView
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
        actions: const [
          AppBarProfile()
        ],
        leading: CircleIconButton(
          icon: const Icon(
            Icons.notifications_rounded,
            size: 30.0,
          ),/*b.Badge(
            badgeContent: Text(
              '2',
              style: _theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            position: b.BadgePosition.topEnd(end: -4, top: -4),
            child: const Icon(
              Icons.notifications_rounded,
              size: 30.0,
            ),
          ),*/
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
          tabs: [
            const FloatingBottomNavbarItem(
              icon: Icons.home_rounded,
              text: "Home",
            ),
             (idAdmin)?
              const FloatingBottomNavbarItem(
                icon: Icons.dashboard,
                text: "Dashboard",
              ):
              const FloatingBottomNavbarItem(
              icon: Icons.account_tree,
              text: "Trip",
            ),
            const FloatingBottomNavbarItem(
              icon: Icons.list_alt,
              text: "Publications",
            ),
          ],
          child: TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: [
              const ExploreView(),
               (idAdmin)? const DashboardProvider()
                :const TripView(),
              const ListPublication()
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
