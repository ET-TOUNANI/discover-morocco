import 'package:discover_morocco/business_logic/services/user_service.dart';
import 'package:discover_morocco/views/ui/authentication/view/profile.dart';
import 'package:discover_morocco/views/ui/navigation/settings/bloc/settings_bloc.dart';
import 'package:discover_morocco/views/ui/publication/view/add_Publication.dart';
import 'package:discover_morocco/views/ui/publication/view/list_Publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/page/signin.dart';

class NavigationMenu extends StatelessWidget {
  static const routeName = '/navigation';

  const NavigationMenu({super.key});

  Future<void> onLogoutPressed(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("LOGOUT"),
              titleTextStyle: const TextStyle(fontSize: 20),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Are you sure, you want to Logout?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SettingsBloc>()
                        .add(const AppLogoutRequested());

                    Navigator.popAndPushNamed(context, SingInPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide.none),
                  child: const Text("Yes"),
                ),
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No")),
              ],
            ));
  }

  void onProfilePressed(BuildContext context) {
    context.read<UserService>().fetchUser(userModel.id);
    Navigator.pushNamed(context, Profile.routeName);
  }

  void createPupPressed(BuildContext context) {
    Navigator.pushNamed(context, PublicationProvider.routeName);
  }
  @override
  Widget build(BuildContext context) {
    //final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
        backgroundColor: theme.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          child: Column(
            children: [
              const Divider(indent: 24, endIndent: 24),
              InkWell(
                onTap: () => onProfilePressed(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text("Profile"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.notifications_none_rounded),
                  title: Text("Notification settings"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                  onTap: () => createPupPressed(context),
                  child: const ListTile(
                    leading: Icon(Icons.public),
                    title: Text("Create new publication"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.translate_rounded),
                  title: Text("Languages"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              InkWell(
                onTap: () => onLogoutPressed(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text("Logout"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
            ],
          ),
        ),
      ),
    );
  }
}
