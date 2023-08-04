import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/models/models/enums/bloc_status.dart';
import '../../admin/bloc/pub_bloc.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PubliacationBloc, WaitingPubState>(
      buildWhen: (previous, current) =>
          current.pubUpdateStatus != previous.pubUpdateStatus,
      builder: (context, state) {
        if (state.pubUpdateStatus == BlocStatus.loading) {
          return Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ),
            );
        }
        else {
          return const SizedBox();
        }
      },
    );
  }
}
