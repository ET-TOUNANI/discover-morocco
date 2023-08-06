import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:discover_morocco/views/ui/authentication/bloc/signin/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Picture extends StatefulWidget {
  const Picture({super.key});

  @override
  State<Picture> createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  Future<void> pickerImagePressed(BuildContext context)async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      context.read<ProfileCubit>().photoChanged(base64Image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (previous, current) => current.photo != previous.photo,
              builder: (context, state) {
                if (state.photo!='') {
                  Uint8List bytes = base64Decode(state.photo);
                  return Image.memory(bytes);
                } else {
                  return Image.asset('assets/mock/profile.png');
                }
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () => pickerImagePressed(context),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor),
              child:
                  const Icon(Icons.camera_alt, color: Colors.black, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
