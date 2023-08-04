import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'circle_button.dart';

class RowPlaceCard extends StatelessWidget {
  final AsyncCallback onTab;
  final AsyncCallback? onRejectTab;
  final AsyncCallback? onApproveTab;
  final AsyncCallback onActionTab;
  final AsyncCallback? onBookingTab;
  final Widget action;
  final String? assetImage;
  final String? networkImage;
  final String title;
  final String? description;

  final Object imageHeroTag;

  const RowPlaceCard({
    super.key,
    required this.onTab,
    this.onApproveTab,
    this.onRejectTab,
    required this.title,
    required this.action,
    required this.onActionTab,
    required this.imageHeroTag,
    this.description,
    this.assetImage,
    this.networkImage,
    this.onBookingTab,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final header = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: imageHeroTag,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Image.network(
              networkImage!,
              width: 105,
              height: 105,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image,
                  size: 150,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 16,
            ),
            child: SizedBox(
              height: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        description!,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        CircleIconButton(
          icon: action,
          onTap: onActionTab,
          backgroundColor: Colors.white54,
          size: 24,
        ),
      ],
    );

    if (onBookingTab == null) {
      return GestureDetector(
        onTap: onTab,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(padding: const EdgeInsets.all(8.0), child: header),
        ),
      );
    }

    //final localizations = AppLocalizations.of(context)!;

    final buttonSize = Size(min(150, mediaQuery.size.width * 0.3), 40);

    final footer = Column(
      children: [
        header,
        const Divider(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Row(
            children: [
              if (onRejectTab != null)
                ElevatedButton(
                  onPressed: onRejectTab,
                  style: ElevatedButton.styleFrom(
                    minimumSize: buttonSize,
                    backgroundColor: theme.buttonTheme.colorScheme!.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text(
                    "Reject",
                  ),
                ),
              const Spacer(),
              if (onApproveTab != null)
                ElevatedButton(
                  onPressed: onApproveTab,
                  style: ElevatedButton.styleFrom(
                    minimumSize: buttonSize,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text(
                    "Approve",
                  ),
                )
            ],
          ),
        )
      ],
    );

    return GestureDetector(
      onTap: onTab,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(padding: const EdgeInsets.all(8.0), child: footer),
      ),
    );
  }
}
