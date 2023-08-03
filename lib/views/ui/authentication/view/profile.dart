import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/views/ui/authentication/bloc/signin/profile_bloc.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/Picture.dart';
import 'package:discover_morocco/views/ui/authentication/widgets/form_inputs/text_inputProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  Widget _emailInput() => TextFormInput(
        buildWhen: (previous, current) => previous.email != current.email,
        label: "Email",
        hint: 'exmaple@email.com',
        textFieldKey: const Key('profile_emailInput_textField'),
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        onChanged: (email, context, state) =>
            context.read<ProfileCubit>().emailChanged(email),
        getError: (context, state) =>
            state.email.invalid ? 'invalid email' : null,
        icon: Icons.email_outlined,
      );
  Widget _nameInput() => TextFormInput(
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
      );
  Widget _phoneInput() => TextFormInput(
        buildWhen: (previous, current) => previous.phone != current.phone,
        label: "Phone",
        hint: '+2126999999',
        textFieldKey: const Key('profile_phoneInput_textField'),
        keyboardType: TextInputType.phone,
        obscureText: false,
        onChanged: (phone, context, state) =>
            context.read<ProfileCubit>().phoneChanged(phone),
        getError: (context, state) => null,
        icon: Icons.twenty_mp_sharp,
      );
  Widget _passwordInput() => TextFormInput(
        buildWhen: (previous, current) => previous.password != current.password,
        label: "Password",
        hint: 'password',
        textFieldKey: const Key('profile_password_textField'),
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (password, context, state) =>
            context.read<ProfileCubit>().passwordChanged(password),
        getError: (context, state) =>
            state.password.invalid ? 'invalid password' : null,
        icon: Icons.lock_outline_rounded,
      );

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        elevation: 0,
        backgroundColor: theme.canvasColor,
      ),
      body: BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(context.read<AuthenticationRepository>()
              //AppLocalizations.of(context)!,
              ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // -- IMAGE with ICON
                  const Picture(),
                  const SizedBox(height: 20),

                  // -- Form Fields
                  Form(
                    child: Column(
                      children: [
                        _nameInput(),
                        const SizedBox(height: 10),
                        _emailInput(),
                        const SizedBox(height: 10),
                        _phoneInput(),
                        const SizedBox(height: 10),
                        _passwordInput(),
                        const SizedBox(height: 20),
                        // -- Form Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => {},
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
          )),
    );
  }
}
