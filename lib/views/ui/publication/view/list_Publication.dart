import 'dart:math';

import 'package:discover_morocco/business_logic/models/models/publication.dart';
import 'package:discover_morocco/views/ui/admin/bloc/pub_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../business_logic/models/models/enums/bloc_status.dart';
import '../../../../business_logic/services/Auth_service.dart';
import '../../../../business_logic/services/publication_service.dart';
import '../../../widgets/headline.dart';
import '../../../widgets/row_place_card.dart';
import '../../book/detail.dart';
import '../../home/explore/widgets/snap_list_shimmer.dart';
import '../../home/widgets/bottom_nav_bar/navbar.dart';

class ListPublication extends StatefulWidget {
  static const String routeName = '/publication/list';
  const ListPublication({super.key});

  @override
  State<ListPublication> createState() => _ListPublicationState();
}

class _ListPublicationState extends State<ListPublication> {
  late Size _snapListSize;

  late MediaQueryData _mediaQuery;
  void _computeCustomCardSize() {
    final height = max(400, _mediaQuery.size.height * 0.62).toDouble();
    _snapListSize = Size(height * (12 / 16), height);
  }

  Widget _listPub() => SizedBox(
        height: _snapListSize.height,
        child: BlocBuilder<PubliacationBloc, WaitingPubState>(
          buildWhen: (previous, current) =>
              current.pubListStatus != previous.pubListStatus ||
              current.publicationsByUser != previous.publicationsByUser,
          builder: (context, state) {
            switch (state.pubListStatus) {
              case BlocStatus.success:
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (state.publicationsByUser.isEmpty)
                          Lottie.asset(
                            "assets/mock/noData.json",
                            width: _mediaQuery.size.width - 40,
                            height: _mediaQuery.size.height / 3,
                          ),
                        ...state.publicationsByUser
                            .map(
                              (e) => RowPlaceCard(
                                imageHeroTag: ValueKey('row_${e.id}'),
                                title: e.title,
                                description: e.description,
                                networkImage: e.imageUrl,
                                onTab: () => onPlaceCardPressed(
                                  e,
                                  ValueKey('row_${e.id}'),
                                ),
                                onActionTab: () => onDeletePressed(e),
                                action: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            )
                            .toList()
                      ]),
                );

              case BlocStatus.initial:
                return SizedBox(
                  height: _snapListSize.height,
                  width: _snapListSize.width,
                  child: const Center(child: CircularProgressIndicator(),),
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
                  height: _mediaQuery.size.height / 3,
                );
              default:
                return Lottie.asset(
                  "assets/mock/noData.json",
                  width: _mediaQuery.size.width - 40,
                  height: _mediaQuery.size.height / 3,
                );
            }
          },
        ),
      );

  @override
  void didChangeDependencies() {
    _mediaQuery = MediaQuery.of(context);
    _computeCustomCardSize();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocProviderContext) => PubliacationBloc(
          blocProviderContext.read<DbService>(),
          blocProviderContext.read<AuthenticationRepository>())
        ..add(PubEventListFetched()),
      child: SingleChildScrollView(
        controller: InheritedDataProvider.of(context).scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headline(text: "My publications"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                    spacing: 16,
                    direction: Axis.horizontal,
                    children: [_listPub()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onPlaceCardPressed(Publication pub, Object imageHeroTag) async {
    Navigator.of(context).pushNamed(
      DetailView.routeName,
      arguments: {
        'pub': pub,
        'imageHeroTag': imageHeroTag,
      },
    );
  }

  Future<void> onDeletePressed(Publication pub) async {

    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Confirmation"),
          titleTextStyle: const TextStyle(fontSize: 20),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "Are you sure, you want to delete this publication?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton(
              onPressed: () {
                context.read<PubliacationBloc>().add(DeletePubEvent(pub: pub));
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
}
