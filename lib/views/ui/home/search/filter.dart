import 'dart:math';
import 'package:discover_morocco/views/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:discover_morocco/views/widgets/headline.dart';

class FilterView extends StatefulWidget {
  static const routeName = '/home/search/filter';
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  //late AppLocalizations _localizations;
  late MediaQueryData _mediaQuery;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    // _localizations = AppLocalizations.of(context)!;
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);
    super.didChangeDependencies();
  }

  Widget _category(String title, String imageUrl, {bool? checked}) {
    checked = Random().nextBool();

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 64,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            imageUrl,
                            width: double.infinity,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (checked) ...[
                          Positioned.fill(
                            child: Container(
                              color: Colors.black26,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white70,
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize = Size(min(150, _mediaQuery.size.width * 0.4), 50);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        elevation: 0,
        backgroundColor: _theme.canvasColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Headline(text: "Category"),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        primary: false,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 24,
                        children: [
                          {
                            "title": "Mountain",
                            "image": "filter_mountain.jpg",
                          },
                          {
                            "title": "Beach",
                            "image": "filter_beach.jpg",
                          },
                          {
                            "title": "Desert",
                            "image": "filter_desert.jpg",
                          },
                          {
                            "title": "Forest",
                            "image": "filter_forest.jpg",
                          },
                          {
                            "title": "Sea",
                            "image": "filter_sea.jpg",
                          },
                          {
                            "title": "Religious",
                            "image": "filter_religious.jpeg",
                          }
                        ]
                            .map((e) => _category(
                                e['title']!, 'assets/mock/${e['image']}'))
                            .toList(),
                      ),
                    ),
                  ),
                  const Headline(text: "Countries"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: DropdownButtonFormField(
                      items: [
                        "Casablanca",
                        "Agadir",
                        "Safi",
                      ]
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      itemHeight: 50,
                      //buttonHeight: 50,
                      iconSize: 24,
                      selectedItemBuilder: (context) => const [
                        Row(
                          children: [
                            Icon(Icons.villa_rounded),
                            Padding(padding: EdgeInsets.all(4)),
                            Text("Casablanca"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.villa_rounded),
                            Padding(padding: EdgeInsets.all(4)),
                            Text("Agadir")
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.villa_rounded),
                            Padding(padding: EdgeInsets.all(4)),
                            Text("Safi")
                          ],
                        ),
                      ],
                      style: _theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      borderRadius: BorderRadius.circular(16),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      hint: const Text("Selected countries"),
                      value: "Casablanca",
                      onChanged: (value) {},
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 32,
              top: 16,
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: buttonSize,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save chosen filter
                    //and go back to MainView

                    Navigator.pushNamed(context, MainView.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: buttonSize,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text("Apply"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
