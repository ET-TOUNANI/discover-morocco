import 'package:discover_morocco/views/ui/admin/view/Dashboard.dart';
import 'package:discover_morocco/views/ui/authentication/page/signin.dart';
import 'package:discover_morocco/views/ui/authentication/view/profile.dart';
//import 'package:discover_morocco/views/ui/authentication/view/auth_code.dart';
import 'package:discover_morocco/views/ui/book/detail.dart';
import 'package:discover_morocco/views/ui/chat/Chat.dart';
import 'package:discover_morocco/views/ui/home/home.dart';
import 'package:discover_morocco/views/ui/home/plan/myPlan.dart';
import 'package:discover_morocco/views/ui/home/search/filter.dart';
import 'package:discover_morocco/views/ui/landing/landing.dart';
import 'package:discover_morocco/views/ui/navigation/menu.dart';
import 'package:discover_morocco/views/ui/notification/notification.dart';
import 'package:discover_morocco/views/ui/publication/view/add_Publication.dart';
import 'package:discover_morocco/views/ui/publication/view/list_Publication.dart';
import 'package:discover_morocco/views/ui/reels/tiktok_video_view.dart';

class Routers {
  static dynamic routes() => {
        Chat.routeName: (_) => const Chat(),
        LandingView.routeName: (_) => const LandingView(),
        SingInPage.routeName: (_) => const SingInPage(),
        Profile.routeName: (_) => const Profile(),
        PublicationProvider.routeName: (_) => const PublicationProvider(),
        DashboardProvider.routeName: (_) => const DashboardProvider(),
        ListPublication.routeName: (_) => const ListPublication(),
        MainView.routeName: (_) => const MainView(),
        MyPlanView.routeName: (_) => const MyPlanView(),
        NotificationView.routeName: (_) => const NotificationView(),
        NavigationMenu.routeName: (_) => const NavigationMenu(),
        FilterView.routeName: (_) => const FilterView(),
        DetailView.routeName: (_) => const DetailView(),
        TiktokVideoView.routeName: (_) => const TiktokVideoView(),
      };
}
