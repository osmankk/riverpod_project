import 'package:dr_map/models/enums.dart';
import 'package:dr_map/providers/map_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapRegionsList extends ConsumerWidget {
  const MapRegionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final regions = MapRegions.values;
    final selectedRegion = ref.watch(selectedRegionProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final loc = ref.watch(appLocalizationsProvider);

    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width / 2,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(loc.regionsLabel,
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            width: 32,
          ),
          ...List.generate(regions.length, (index) {
            final region = regions[index];

            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180),
              child: RadioListTile<MapRegions>(
                  value: region,
                  title: Text(ref.watch(localizedMapRegionsProvider(region))),
                  groupValue: selectedRegion,
                  onChanged: (value) {
                    ref.read(selectedRegionProvider.notifier).update(value!);
                  }),
            );
          })
        ],
      ),
    );
  }
}
