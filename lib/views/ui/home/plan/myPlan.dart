import 'dart:math';

import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/models/models/destination.dart';
import 'package:discover_morocco/views/ui/home/plan/widgets/ongoing_trip.dart';
import 'package:flutter/material.dart';

import '../../../../business_logic/models/models/enums/icon_class.dart';
import '../../../../business_logic/models/models/ongoing_trip.dart';
import '../../../../business_logic/models/models/ongoing_trip_timeline.dart';
import '../../../utils/constants.dart';

class MyPlanView extends StatefulWidget {

  const MyPlanView({super.key});

  @override
  State<MyPlanView> createState() => _MyPlanViewState();
}

class _MyPlanViewState extends State<MyPlanView> {
  late ThemeData _theme;

  final random = Random();

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);

    super.didChangeDependencies();
  }

  Future<void> onPlaceBookmarkPressed(String id) async {}
  Future<void> onBookingTab(String id) async {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //controller: InheritedDataProvider.of(context).scrollController,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16,
                left: 24,
                right: 24,
              ),
              child: Text(
                'My Plan',
                style: _theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            OnGoingTripWidget(
              model: OngoingTripModel(
                id: snapList[0]['id']!,
                title: snapList[0]['id']!,
                destination: DestinationModel(id: '1' ,city: snapList[0]['location']!, categories: const []),// TODO: Change it with destination model
                imageUrl: snapList[0]['imageUrl']!,
                timeline: [
                  OngoingTripTimelineModel(
                    id: 'kjfchnlhfnlaciunhn34n',
                    title: 'Airplan Reservation',
                    description: 'Airboss of America Corp.',
                    date: '2022-2-12',
                    time: '13:15',
                    done: true,
                    iconClass: IconClass.materialIcon,
                    icon: Icons.airplane_ticket.codePoint,
                  ),
                  OngoingTripTimelineModel(
                    id: '987jkdfshdfsnjdfs',
                    title: 'Hotel Reservation',
                    description: 'Airbnb Vacation rental company',
                    date: '2022-2-13',
                    time: '07:15',
                    done: true,
                    iconClass: IconClass.materialIcon,
                    icon: Icons.hotel_rounded.codePoint,
                  ),
                  OngoingTripTimelineModel(
                    id: '987jkdfshdfsnjdfs',
                    title: 'Tourism tour',
                    description: 'Miniature Tourism Group',
                    date: 'Pending',
                    done: false,
                    iconClass: IconClass.materialIcon,
                    icon: Icons.tour_rounded.codePoint,
                  ),
                  OngoingTripTimelineModel(
                    id: 'sdlfkmjdlsf9834jkhn',
                    title: 'Photographer',
                    description: 'Not determined yet',
                    date: 'Pending',
                    done: false,
                    iconClass: IconClass.materialIcon,
                    icon: Icons.camera_alt_rounded.codePoint,
                  ),
                ],
                user: const UserModel(id: '1'),//TODO : Add currentUSER
              ),
            ),
          ],
        ),
      ),
    );
  }
}
