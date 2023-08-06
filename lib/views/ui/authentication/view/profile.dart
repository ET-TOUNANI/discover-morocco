import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/views/ui/authentication/bloc/signin/profile_bloc.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/Picture.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/text_inputProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../business_logic/services/user_service.dart';

class Profile extends StatelessWidget {

  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
        create: (_) => ProfileCubit(
      context.read<UserService>(),
      context.read<AuthenticationRepository>(),
    ),
    child: const ProfileProvider());
  }
}

class ProfileProvider extends StatefulWidget {
  const ProfileProvider({super.key});

  @override
  State<ProfileProvider> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileProvider> {
  // late AppLocalizations localizations;
  late MediaQueryData mediaQuery;
  late ThemeData theme;
  //late double ;
  @override
  void didChangeDependencies() {
    mediaQuery = MediaQuery.of(context);
    theme = Theme.of(context);

    super.didChangeDependencies();
  }

  Widget _nameInput() => BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {return TextFormInput(
        buildWhen: (previous, current) => previous.name != current.name,
        label: "Name",
        hint: 'Mohammed...',
        textFieldKey: const Key('profile_nameInput_textField'),
        keyboardType: TextInputType.name,
        obscureText: false,
        onChanged: (name, context, state) =>
            context.read<ProfileCubit>().nameChanged(name),
        getError: (context, state) => null,
        icon: Icons.info_outline,
    initialValue: state.name,
  );});
  Widget _phoneInput() => BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {return TextFormInput(
        buildWhen: (previous, current) => previous.phone != current.phone,
        label: "Phone",
        hint: '+2126999999',
        textFieldKey: const Key('profile_phoneInput_textField'),
        keyboardType: TextInputType.phone,
        obscureText: false,
        onChanged: (phone, context, state) =>
            context.read<ProfileCubit>().phoneChanged(phone),
        getError: (context, state) => null,
        icon: Icons.phone,
    initialValue: state.phone,
      );});

  Future<void> editProfilePressed(BuildContext context) async {
    await context.read<ProfileCubit>().editProfile();
    }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) async {
      if (state.status.isSubmissionFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Please try again'),
            ),
          );
      }

      if (state.status.isSubmissionSuccess) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Operation Done"),
            ),
          );
      }
    },
    child: Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Edit profile"),
            elevation: 0,
            backgroundColor: theme.canvasColor,
          ),
          body:  SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(height: 50),
                      // -- IMAGE with ICON
                      const Picture(),
                      const SizedBox(height: 20),

                      // -- Form Fields
                      Form(
                        child: Column(
                          children: [
                            _nameInput(),
                            const SizedBox(height: 10),
                            _phoneInput(),
                            const SizedBox(height: 20),
                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:()=> editProfilePressed(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.primaryColor,
                                    side: BorderSide.none,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                    shape: const StadiumBorder()),
                                child: Text("Edit Profile",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => current.status != previous.status,
          builder: (context, state) => state.status.isSubmissionInProgress
              ? Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ),
          )
              : const SizedBox(),
        )
      ],
    ));
  }
}

/*
BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (previous, current) => current.photo != previous.photo,
              builder: (context, state) {
                if (state.photo.isNotEmpty) {
                  Uint8List bytes = base64Decode(state.photo);
                  return Image.memory(bytes);
                } else {
                  return Image.asset('assets/mock/profile.png');
                }
              },
            ),
 */