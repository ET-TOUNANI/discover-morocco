import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/views/ui/authentication/bloc/signin/signin_bloc.dart';
import 'package:discover_morocco/views/ui/authentication/view/singin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingInPage extends StatelessWidget {
  static const routeName = '/auth/signup';

  const SingInPage({super.key});

  static Page<void> page() => const MaterialPage(child: SingInPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInCubit>(
        create: (_) => SignInCubit(context.read<AuthenticationRepository>()
            //AppLocalizations.of(context)!,
            ),
        child: const LoginView(),
      ),
    );
  }
}
