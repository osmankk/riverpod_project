import 'package:dr_map/providers/map_providers.dart';
import 'package:dr_map/widgets/all_provinces_list.dart';
import 'package:dr_map/widgets/app_lang_switch.dart';
import 'package:dr_map/widgets/app_theme_switch.dart';
import 'package:dr_map/widgets/drmap.dart';
import 'package:dr_map/widgets/map_assets_list.dart';
import 'package:dr_map/widgets/map_regions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DRMapApp extends StatelessWidget {
  const DRMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.surfaceContainer,
        body: Center(
          child: Consumer(builder: (context, ref, child) {
            final fetchProvinces = ref.watch(fetchProvincesProvider);

            return fetchProvinces.when(
              data: (data) {
                return Stack(
                  children: [
                    Center(
                      child: InteractiveViewer(
                          clipBehavior: Clip.none, child: DRMap()),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: MapAssetsList(),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: AllProvincesList(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MapRegionsList(),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          AppThemeSwitch(),
                          SizedBox(
                            width: 32,
                          ),
                          AppLangSwitch()
                        ],
                      ),
                    )
                  ],
                );
              },
              error: (e, s) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning),
                  SizedBox(
                    width: 32,
                  ),
                  Text(e.toString()),
                ],
              ),
              loading: () => CircularProgressIndicator(),
            );
          }),
        ));
  }
}
