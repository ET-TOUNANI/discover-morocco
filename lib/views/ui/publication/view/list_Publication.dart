import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/models/models/enums/icon_class.dart';
import '../../../../business_logic/services/db_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/headline.dart';
import '../../../widgets/row_place_card.dart';
import '../../book/detail.dart';
import '../../home/explore/bloc/explore_bloc.dart';
import '../../home/widgets/bottom_nav_bar/navbar.dart';
class ListPublication extends StatefulWidget {
  static const String routeName = '/home/listPublication';
  const ListPublication({super.key});

  @override
  State<ListPublication> createState() => _ListPublicationState();
}

class _ListPublicationState extends State<ListPublication> {


  final random = Random();



  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocProviderContext) =>
      ExploreBloc(blocProviderContext.read<DbService>())
        ..add(ExploreFetched()),
      child: SingleChildScrollView(
        controller: InheritedDataProvider.of(context).scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
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
                  children: snapList
                      .map(
                        (e) => RowPlaceCard(
                      imageHeroTag: ValueKey('row_${e['id']}'),
                      title: e['title']!,
                      description: e['description']!,
                      assetImage: e['imageUrl']!,
                      onTab: () => onPlaceCardPressed(
                        e['id']!,
                        ValueKey('row_${e['id']}'),
                      ),
                      onActionTab: () => onPlaceBookmarkPressed(e['id']!),
                      price: random.nextInt(400) + 100,
                      action: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
