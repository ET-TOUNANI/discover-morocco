import 'package:flutter/material.dart';

import '../../../business_logic/models/models/place_directions.dart';

class DistanceAndTime extends StatelessWidget {
  const DistanceAndTime(
      {Key? key, this.placeDirections, this.isTimeAndDistanceVisiable})
      : super(key: key);
  final PlaceDirections? placeDirections;

  // ignore: prefer_typing_uninitialized_variables
  final isTimeAndDistanceVisiable;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisiable,
      child: Positioned(
        top: 0,
        bottom: 570,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.access_time_filled,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDuration,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.directions_car_filled,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDistance,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
