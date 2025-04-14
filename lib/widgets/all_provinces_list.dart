import 'package:dr_map/providers/map_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProvincesList extends ConsumerWidget {
  const AllProvincesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProvinces = ref.watch(provincesListProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final loc = ref.watch(appLocalizationsProvider);

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      width: 300,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loc.provincesLabel,
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            width: 32,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allProvinces.length,
              itemBuilder:(context, index) {
                
                final province = allProvinces[index];
                final selectedProvinces = ref.watch(selectedProvincesProvider);
                final value = selectedProvinces.contains(province);

                return CheckboxListTile(
                  value: value,
                  title: Text(province.name),
                  onChanged: (value) {
                    if (value!) {
                      selectedProvinces.add(province);
                    } else {
                      selectedProvinces.remove(province);
                    }

                    ref.read(selectedProvincesProvider.notifier).update(
                      selectedProvinces,
                    );
                  });
              },
            ),
          ),
          Divider(),
          Consumer(
            builder: (context, ref, child) {
              return CheckboxListTile(
                value: allProvinces.length == ref.watch(selectedProvincesProvider).length,
                title: Text(loc.allProvincesLabel),
                onChanged: (value) {
                  if (value!) {
                    ref.read(selectedProvincesProvider.notifier).update(
                      allProvinces,
                    );
                  } else {
                    ref.read(selectedProvincesProvider.notifier).update(
                      [],
                    );
                  }
                },
              );
            }
          )
        ],
      ),
    );
  }
}