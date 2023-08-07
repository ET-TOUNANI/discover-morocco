import 'package:discover_morocco/views/ui/home/plan/bloc/trip_bloc.dart';
import 'package:discover_morocco/views/ui/home/widgets/bottom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../business_logic/services/user_service.dart';
import 'filter.dart';
import 'myPlan.dart';

class TripView extends StatefulWidget {
  static const route = '/home/plan';
  const TripView({super.key});

  @override
  State<TripView> createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TripBloc>(
        create: (_) => TripBloc(
          context.read<UserService>()
        ),
        child: SafeArea(
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
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  borderRadius: const BorderRadiusDirectional.only(
                                    topStart: Radius.circular(32),
                                    bottomStart: Radius.circular(32),
                                  ).resolve(Directionality.of(context)),
                                  child: const SizedBox(
                                    height: 50,
                                    width: 60,
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                  width: 0,
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Where's your destination?",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        alignLabelWithHint: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8.0),
                          child: Material(
                            color: _theme.primaryColor,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(FilterView.routeName
                                );
                              },
                              splashColor: Colors.orange,
                              customBorder: const CircleBorder(),
                              child: Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/images/sliders.svg',
                                  height: 24,
                                  color: Colors.white,
                                  semanticsLabel: 'Beautiful Destinations',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const MyPlanView()
                ],
              ),
            ),
          ),
        ));

  }
}
