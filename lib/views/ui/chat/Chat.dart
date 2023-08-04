import 'package:discover_morocco/views/ui/chat/widgets/ButtonNavigationBar.dart';
import 'package:discover_morocco/views/ui/chat/widgets/Messages.dart';
import 'package:discover_morocco/views/ui/navigation/menu.dart';
import 'package:discover_morocco/views/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Chat extends StatelessWidget {
  static const routeName = '/chat';
  const Chat({Key? key}) : super(key: key);

  void onNotificationPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onProfilePicturePressed(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationMenu.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
                    onTap: () => onProfilePicturePressed(context),
                  ),
                ),
              ),
            ),
          ],
          leading: CircleIconButton(
            icon: const Icon(
              Icons.keyboard_backspace_outlined,
              size: 30.0,
            ),
            onTap: () => onNotificationPressed(context),
            padding: const EdgeInsetsDirectional.only(start: 4),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: ButtonNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Messages(),
        ));
  }
}
