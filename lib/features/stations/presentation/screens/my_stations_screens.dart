import 'package:el_tiempo_en_galve_app/features/stations/presentation/providers/stations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/background_gradient.dart';

class MyStationsScreen extends ConsumerWidget {
  
  static const name = 'stations_screen';
  
  const MyStationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("Mis estaciones"),
        ),
        body: _MyStationsWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: const Text("Añadir estacion"),
        ),
      ),
    );
  }
}

class _MyStationsWidget extends ConsumerWidget {
  const _MyStationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationsrovider = ref.watch(stationsProvider);

    return ListView.builder(
      itemCount: stationsrovider.stations.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){},
        child: Text(stationsrovider.stations[index].name),
      ),
    );
  }
}