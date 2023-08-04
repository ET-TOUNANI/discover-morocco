import 'package:discover_morocco/business_logic/services/Auth_service.dart';
import 'package:discover_morocco/business_logic/services/db_service.dart';
import 'package:discover_morocco/views/ui/publication/bloc/publication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';

import '../../home/home.dart';
import '../widgets/text_inputPublication.dart';
// Provider for PublicationCubit

class PublicationProvider extends StatelessWidget {
  static const routeName = '/Add_Publication';
  const PublicationProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PublicationCubit(
          context.read<AuthenticationRepository>(), context.read<DbService>()),
      child: const AddPublication(),
    );
  }
}

class AddPublication extends StatefulWidget {
  const AddPublication({super.key});

  @override
  State<AddPublication> createState() => _AddPublicationState();
}

class _AddPublicationState extends State<AddPublication> {
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

  Widget _descriptionInput() => TextFormInput(
        buildWhen: (previous, current) =>
            previous.description != current.description,
        label: "Description",
        hint: 'Type in...',
        textFieldKey: const Key('Add_Publication_descriptionInput_textField'),
        keyboardType: TextInputType.text,
        obscureText: false,
        height: true,
        onChanged: (description, context, state) =>
            context.read<PublicationCubit>().descriptionChanged(description),
        getError: (context, state) => null,
        icon: Icons.menu_book_sharp,
      );
  Widget _titleInput() => TextFormInput(
        buildWhen: (previous, current) => previous.title != current.title,
        label: "Title",
        hint: 'Type in...',
        textFieldKey: const Key('Add_Publication_nameInput_textField'),
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: (title, context, state) =>
            context.read<PublicationCubit>().titleChanged(title),
        getError: (context, state) => null,
        icon: Icons.info_outline,
      );
  Widget _imageInput() => TextFormInput(
        buildWhen: (previous, current) => previous.image != current.image,
        label: "Image Url",
        hint: 'Paste image link here',
        textFieldKey: const Key('Add_Publication_imageInput_textField'),
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: (image, context, state) =>
            context.read<PublicationCubit>().imageChanged(image),
        getError: (context, state) => null,
        icon: Icons.image,
      );
  Widget _videoInput() => TextFormInput(
        buildWhen: (previous, current) => previous.video != current.video,
        label: "Video",
        hint: 'Paste video link here',
        textFieldKey: const Key('Add_Publication_videoInput_textField'),
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: (video, context, state) =>
            context.read<PublicationCubit>().videoChanged(video),
        getError: (context, state) => null,
        icon: Icons.video_camera_back,
      );
  Future<void> onCreatePubPressed(BuildContext context) async {
    await context.read<PublicationCubit>().createPub();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PublicationCubit, PublicationState>(
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
                content: Text("Publication has been created"),
              ),
            );
          Navigator.popAndPushNamed(context, MainView.routeName);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text("Add Publication"),
              elevation: 0,
              backgroundColor: theme.canvasColor,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // -- Form Fields
                    Form(
                      child: Column(
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/logo_black.svg',
                              height: 70,
                              semanticsLabel: 'Discover Morocco',
                            ),
                          ),
                          _titleInput(),
                          const SizedBox(height: 10),
                          _descriptionInput(),
                          const SizedBox(height: 10),
                          _imageInput(),
                          const SizedBox(height: 10),
                          _videoInput(),
                          const SizedBox(height: 20),

                          // -- Form Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => onCreatePubPressed(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  side: BorderSide.none,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: const StadiumBorder()),
                              child: Text("Create",
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
            ),
          ),
          BlocBuilder<PublicationCubit, PublicationState>(
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
      ),
    );
  }
}
