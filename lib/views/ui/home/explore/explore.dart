import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:discover_morocco/business_logic/models/models/enums/bloc_status.dart';
import 'package:discover_morocco/business_logic/models/models/enums/icon_class.dart';
import 'package:discover_morocco/business_logic/models/models/place_option.dart';
import 'package:discover_morocco/business_logic/models/models/video_category.dart';
import 'package:discover_morocco/business_logic/services/db_service.dart';
import 'package:discover_morocco/views/ui/book/detail.dart';
import 'package:discover_morocco/views/ui/home/explore/widgets/snap_list.dart';
import 'package:discover_morocco/views/ui/home/explore/widgets/snap_list_shimmer.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:discover_morocco/views/utils/constants.dart';
import 'package:discover_morocco/views/widgets/headline.dart';
import 'package:discover_morocco/views/widgets/medium_place_card.dart';

import 'bloc/explore_bloc.dart';

class ExploreView extends StatefulWidget {
  static const String routeName = '/home/explore';

  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  //late AppLocalizations _localizations;
  late MediaQueryData _mediaQuery;

  late Size _snapListSize;

  final random = Random();

  void _computeCustomCardSize() {
    final height = max(400, _mediaQuery.size.height * 0.62).toDouble();
    _snapListSize = Size(height * (9 / 16), height);
  }

  @override
  void didChangeDependencies() {
    //_localizations = AppLocalizations.of(context)!;
    _mediaQuery = MediaQuery.of(context);

    _computeCustomCardSize();

    super.didChangeDependencies();
  }

  Future<void> onCategoryPressed(PlaceCategoryModel categoryModel) async {}

  void onButtomNavigatorExplorePressed(String id) {
    Navigator.of(context).pushNamed(ExploreView.routeName, arguments: id);
  }

  Widget _categories() => SizedBox(
        height: _snapListSize.height,
        child: BlocBuilder<ExploreBloc, ExploreState>(
          buildWhen: (previous, current) =>
              current.categoriesStatus != previous.categoriesStatus ||
              current.categories != previous.categories,
          builder: (context, state) {
            switch (state.categoriesStatus) {
              case BlocStatus.success:
                return SnapList(
                  models: state.categories,
                  height: _snapListSize.height,
                  width: _snapListSize.width,
                  onPressed:
                      onCategoryPressed ,
                );
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
                return const Text('Error');
              default:
                return const Text('Error');
            }
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocProviderContext) =>
          ExploreBloc(blocProviderContext.read<PlaceRepository>())
            ..add(ExploreFetched()),
      child: SingleChildScrollView(
        controller: InheritedDataProvider.of(context).scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categories(),
              const Headline(text: "Popular"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 16,
                    children: snapList
                        .asMap()
                        .map(
                          (index, e) => MapEntry(
                            index,
                            MediumPlaceCard(
                              imageHeroTag: ValueKey('col_${e['id']}'),
                              onTab: () => onPlaceCardPressed(
                                e['id']!,
                                ValueKey('col_${e['id']}'),
                              ),
                              onActionTab: () =>
                                  onPlaceBookmarkPressed(e['id']!),
                              price: random.nextInt(400) + 100,
                              options: [
                                PlaceOptionModel(
                                  iconClass: IconClass.materialIcon,
                                  icon: Icons.king_bed_rounded.codePoint,
                                  value: '${random.nextInt(3) + 1}',
                                ),
                                PlaceOptionModel(
                                  iconClass: IconClass.materialIcon,
                                  icon: Icons.meeting_room.codePoint,
                                  value: '${random.nextInt(3) + 1}',
                                ),
                              ],
                              title: e['title']!,
                              description: e['description']!.substring(0, 100),
                              assetImage:e['imageUrl']!,
                              action: const Icon(
                                Icons.bookmark_border_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
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
