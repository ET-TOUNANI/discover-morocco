import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:discover_morocco/views/ui/navigation/settings/bloc/settings_bloc.dart';

class NavigationMenu extends StatelessWidget {
  static const routeName = '/navigation';

  const NavigationMenu({super.key});

  Future<void> onLogoutPressed(BuildContext context) async {
    context.read<SettingsBloc>().add(const AppLogoutRequested());
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.translate_rounded),
                  title: Text("Languages"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.shield_outlined),
                  title: Text("Terms and conditions"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.lock_outline_rounded),
                  title: Text("Privacy"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.support_agent_rounded),
                  title: Text("Help center"),
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
              // const Divider(indent: 24, endIndent: 24),
            ],
          ),
        ),
      ),
    );
  }
}
