import 'package:discover_morocco/views/ui/extensions/enum_extension.dart';
import 'package:discover_morocco/views/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';

import '../../../../../business_logic/models/models/ongoing_trip.dart';
import '../../../book/detail.dart';
import '../bloc/trip_bloc.dart';
import '../filter.dart';

class OnGoingTripWidget extends StatefulWidget {
  final OngoingTripModel? model;
  const OnGoingTripWidget({
    super.key,
    required this.model,
  });

  @override
  State<OnGoingTripWidget> createState() => _OnGoingTripWidgetState();
}

class _OnGoingTripWidgetState extends State<OnGoingTripWidget> {
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);

    super.didChangeDependencies();
  }

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: const ValueKey('ongoing_1'),
              child: Container(
                height: 200,
                width: double.infinity,
                // margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/mock/filter_sea.jpg"), // Use AssetImage to load the SVG asset
                    fit: BoxFit.cover, // Adjust the fit based on your requirements
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.face,
                                color: Colors.white,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 8.0,
                                  ),
                                  child: Text(
                                    "Welcome to Morocco :)",
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.clip,
                                    style: _theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: OutlinedButton(
                        onPressed: () => onPlaceCardPressed(),
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: _theme.primaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          "Add trip",
                          style: _theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.model != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  "schedule",
                  style: _theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (widget.model != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16,
                  bottom: 16,
                ),
                child: (widget.model!.timeline.isNotEmpty)
                    ? FixedTimeline.tileBuilder(
                        theme: TimelineThemeData(
                          nodePosition: 0,
                          color: Colors.grey.shade300,
                          indicatorTheme: const IndicatorThemeData(
                            position: 0,
                          ),
                          connectorTheme: const ConnectorThemeData(
                            indent: 8,
                            thickness: 2.5,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          itemCount: widget.model!.timeline.length,
                          contentsBuilder: (_, index) {
                            final timeline = widget.model!.timeline[index];
                            return Padding(
                                padding: const EdgeInsetsDirectional.only(
                                start: 16,
                                bottom:17,
                                  top: 0
                            ),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0), // Add appropriate spacing here
                                  child: Text(
                                    timeline.destination.city,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.clip,
                                    style: _theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Checkbox(value: timeline.done, onChanged: (value) {
                                  BlocProvider.of<TripBloc>(context).add(UpdatePlanEvent(index, (value ?? false)));
                                }),],
                            ),);
                          },
                          indicatorBuilder: (_, index) {
                            final timeline = widget.model!.timeline[index];
                            if (timeline.done) {
                              return Indicator.widget(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      height: 20,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          timeline.date,
                                          style: _theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _theme.primaryColor,
                                      ),
                                      width: 32,
                                      height: 32,
                                      child: const Icon(
                                        Icons.access_alarm_outlined,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Indicator.widget(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      height: 20,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          timeline.date,
                                          style: _theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      width: 32,
                                      height: 32,
                                      child: const Icon(
                                        Icons.access_alarm_outlined,
                                        color: Colors.grey,
                                        size: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          connectorBuilder: (_, index, ___) => Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 76),
                            child: SolidLineConnector(
                              color: widget.model!.timeline[index].done
                                  ? _theme.primaryColor
                                  : null,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          "Try to configure your plan",
                          style: _theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16,
                  bottom: 16,
                ),
                child: Center(
                  child: Text(
                    "No Data found",
                    style: _theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> onPlaceCardPressed() async {
    Navigator.of(context).pushNamed(FilterView.routeName);
  }
}
