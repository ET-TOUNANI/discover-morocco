import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/services/Auth_service.dart';
import '../../../../business_logic/services/user_service.dart';
import '../../authentication/bloc/signin/profile_bloc.dart';
import '../../navigation/menu.dart';

class AppBarProfile extends StatelessWidget {

  const AppBarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
        create: (_) => ProfileCubit(
          context.read<UserService>(),
          context.read<AuthenticationRepository>(),
        ),
        child: const AppBarProfile2());
  }
}

class AppBarProfile2 extends StatefulWidget {
  const AppBarProfile2({super.key});

  @override
  State<AppBarProfile2> createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile2> {
  void onProfilePicturePressed() {
    Navigator.of(context).pushNamed(NavigationMenu.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child:
        BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => current.photo != previous.photo,
          builder: (context, state) {
            return Ink.image(
              image: (state.photo != '')
                  ? MemoryImage(base64Decode(state.photo))
                  : const AssetImage('assets/mock/profile.png') as ImageProvider,
              width: 42,
              height: 42,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: onProfilePicturePressed,
              ),
            );
          },
        ),


      ),
    );
  }
}
