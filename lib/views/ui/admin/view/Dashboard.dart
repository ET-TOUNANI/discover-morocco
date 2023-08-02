import 'dart:math';

import 'package:discover_morocco/views/ui/book/detail.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:discover_morocco/views/utils/constants.dart';
import 'package:discover_morocco/views/widgets/headline.dart';
import 'package:discover_morocco/views/widgets/row_place_card.dart';
import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  static const String routeName = '/admin/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  final random = Random();

  @override
  void didChangeDependencies() {

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
  Future<void> onBookingTab(String id) async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: SingleChildScrollView(
        controller: InheritedDataProvider.of(context).scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Headline(text: "Admin Panel"),

                ],
              ),
              ...snapList
                  .take(4)
                  .map(
                    (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RowPlaceCard(
                    imageHeroTag: ValueKey('row_${e['id']}'),
                    title: e['title']!,
                    description: e['description']!,
                    assetImage: e['imageUrl']!,
                    onTab: () => onPlaceCardPressed(
                      e['id']!,
                      ValueKey('row_${e['id']}'),
                    ),
                    onActionTab: () => onPlaceBookmarkPressed(e['id']!),
                    onBookingTab: () => onBookingTab(e['id']!),
                    price: random.nextInt(400) + 100,
                    action: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
