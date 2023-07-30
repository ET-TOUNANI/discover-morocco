import 'package:discover_morocco/views/ui/authentication/bloc/signin/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Picture extends StatelessWidget {
  const Picture({super.key});


  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                  current.photo != previous.photo,
                  builder: (context, state) {
                    return Image(image: AssetImage(state.photo));
                  })),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () => context
                .read<ProfileCubit>()
                .photoChanged("assets/mock/profile.png"),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor),
              child: const Icon(Icons.camera_alt,
                  color: Colors.black, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
