/// *****************************************************************************
/// Copyright (c) 2023.  Made With Love By Abderrahmane ET-TOUNANI
///****************************************************************************
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_morocco/business_logic/services/user_service.dart';
import 'package:discover_morocco/views/ui/chat/bloc/chat/chat_bloc.dart';
import 'package:discover_morocco/views/ui/home/home.dart';
import 'package:discover_morocco/views/ui/landing/landing.dart';
import 'package:discover_morocco/views/ui/navigation/settings/bloc/settings_bloc.dart';
import 'package:discover_morocco/views/utils/Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business_logic/models/authentication/models/enums/status.dart';
import 'business_logic/services/Auth_service.dart';
import 'business_logic/services/publication_service.dart';
import 'business_logic/services/push_notification_service.dart';
import 'config/router_config.dart';
import 'firebase_options.dart';

late SharedPreferences sharesPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  sharesPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initNotification();
  runApp(const TourismApp());
}
// category

class TourismApp extends StatelessWidget {
  const TourismApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthenticationRepository()),
        RepositoryProvider(
          create: (_) => DbService(FirebaseFirestore.instance),
        ),
        RepositoryProvider(
          create: (_) => UserService(FirebaseFirestore.instance,),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (BuildContext providerContext) => SettingsBloc(
              providerContext.read<UserService>(),
              sharedPreferences: sharesPreferences,

              authenticationRepository:
                  providerContext.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider(create: (context) => ChatBloc()),
        ],

        child: BlocConsumer<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            // if(state.authStatus == AuthenticationStatus.unauthenticated) {
            //   Naviga
            // }
          },
          builder: (BuildContext context, state) => MaterialApp(
              onGenerateTitle: (context) =>
                  "Discover Morocco",
              debugShowCheckedModeBanner: false,
              routes: Routers.routes(),
              theme: Themes().getBrightness(state.brightness),
              home: state.authStatus == AuthenticationStatus.unauthenticated
                  ? const LandingView()
                  : const MainView()),
        ),
      ),
    );
  }
}
