import 'dart:math';

import 'package:discover_morocco/business_logic/models/models/publication.dart';
import 'package:discover_morocco/views/ui/book/detail.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:discover_morocco/views/widgets/headline.dart';
import 'package:discover_morocco/views/widgets/row_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../business_logic/models/models/enums/bloc_status.dart';
import '../../../../business_logic/services/Auth_service.dart';
import '../../../../business_logic/services/db_service.dart';
import '../../home/explore/widgets/snap_list_shimmer.dart';
import '../../publication/widgets/Loading.dart';
import '../bloc/pub_bloc.dart';

class DashboardProvider extends StatelessWidget {
  static const String routeName = '/admin/dashboard';
  const DashboardProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocProviderContext) => PubliacationBloc(
          blocProviderContext.read<DbService>(),
          blocProviderContext.read<AuthenticationRepository>())
        ..add(WaitingPubEventFetched()),
      child: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Size _snapListSize;

  late MediaQueryData _mediaQuery;
  void _computeCustomCardSize() {
    final height = max(400, _mediaQuery.size.height * 0.62).toDouble();
    _snapListSize = Size(height * (12 / 16), height);
  }

  @override
  void didChangeDependencies() {
    _mediaQuery = MediaQuery.of(context);
    _computeCustomCardSize();
    super.didChangeDependencies();
  }

  Future<void> onPlaceCardPressed(String id, Object imageHeroTag) async {
    Navigator.of(context).pushNamed(
      DetailView.routeName,
      arguments: {
        'id': id,
        'imageHeroTag': imageHeroTag,
      },
    );
  }

  Future<void> onPlaceBookmarkPressed(String id) async {}
// TODO: Send notification to user
  Future<void> onRejectPressed(Publication pub) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Confirmation"),
              titleTextStyle: const TextStyle(fontSize: 20),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Are you sure, you want to reject this publication?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<PubliacationBloc>()
                        .add(RejectPubEvent(pub: pub));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide.none),
                  child: const Text("Yes"),
                ),
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No")),
              ],
            ));
  }

  Future<void> onApprovePressed(Publication pub) async {
    context.read<PubliacationBloc>().add(ApprovePubEvent(pub: pub));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Publication has been Approved"),
        ),
      );
  }

  Future<void> onBookingTab(String id) async {}

  Widget _waitingPub() => SizedBox(
        height: _snapListSize.height,
        child: BlocBuilder<PubliacationBloc, WaitingPubState>(
          buildWhen: (previous, current) =>
              current.waitingPubStatus != previous.waitingPubStatus ||
              current.publications != previous.publications,
          builder: (context, state) {
            switch (state.waitingPubStatus) {
              case BlocStatus.success:
                return Wrap(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.publications.isEmpty)
                        Lottie.asset(
                          "assets/mock/noData.json",
                          width: _mediaQuery.size.width - 40,
                          height: _mediaQuery.size.height / 3,
                        ),
                      ...state.publications
                          .map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: RowPlaceCard(
                                imageHeroTag: ValueKey('row_${e.id}'),
                                title: e.title,
                                description: e.description,
                                networkImage: e.imageUrl,
                                onTab: () => onPlaceCardPressed(
                                  e.id,
                                  ValueKey('row_${e.id}'),
                                ),
                                onActionTab: () => onPlaceBookmarkPressed(e.id),
                                onBookingTab: () => onBookingTab(e.id),
                                action: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                onApproveTab: () => onApprovePressed(e),
                                onRejectTab: () => onRejectPressed(e),
                              ),
                            ),
                          )
                          .toList()
                    ]);

              case BlocStatus.initial:
                return SizedBox(
                  height: _snapListSize.height,
                  width: _snapListSize.width,
                );
              case BlocStatus.loading:
                return SnapListShimmer(
                  height: _snapListSize.height,
                  width: _snapListSize.width,
                );
              case BlocStatus.failure:
                return Lottie.asset(
                  "assets/mock/noData.json",
                  width: _mediaQuery.size.width - 40,
                  height: _snapListSize.height / 1.5,
                );
              default:
                return Lottie.asset(
                  "assets/mock/noData.json",
                  width: _mediaQuery.size.width - 40,
                  height: _snapListSize.height / 1.5,
                );
            }
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          controller: InheritedDataProvider.of(context).scrollController,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Headline(text: "Admin Panel"), _waitingPub()],
            ),
          ),
        ),
        const Loading()
      ],
    );
  }
}
