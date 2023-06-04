import 'package:el_tiempo_en_galve_app/features/stations/presentation/providers/stations_provider.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/screens/crete_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/background_gradient.dart';
import '../../domain/entities/weather_station.dart';

class MyStationsScreen extends ConsumerWidget {
  
  static const name = 'stations_screen';
  
  const MyStationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("Mis estaciones"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: const _MyStationsWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed(CreateStationScreen.name),
          child: const Icon(Icons.add),
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
        child: _StationCard(station: stationsrovider.stations[index],),
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  
  final WeatherStation station;

  const _StationCard({
    required this.station
  });


  @override
  Widget build(BuildContext context) {
    //final colors = Theme.of(context);
    return Column(
      children: [
        _SuperiorCardStation(station: station),
        _InferiorcardStation(station: station)
      ],
    );
  }
}


class _SuperiorCardStation extends ConsumerWidget {
  const _SuperiorCardStation({
    required this.station,
  });

  final WeatherStation station;

  @override
  Widget build(BuildContext context, ref) {

    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Card(
        margin: const EdgeInsets.only(bottom: 4, top: 0.5, left: 10, right: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          side: BorderSide(
            width: 0.2
          )
        ),            
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(station.name, style: theme.textTheme.headlineSmall),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonPadding: const EdgeInsets.all(0),
              
                children: [
                  IconButton(onPressed: (){
                    print(station.name);
                  }, icon: const Icon(Icons.edit)),                      
                  IconButton(onPressed: () async {
                    await ref.read(stationsProvider.notifier).deleteStation(station);
                  }, icon: const Icon(Icons.remove_circle_outline_outlined)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class _InferiorcardStation extends StatelessWidget {
  const _InferiorcardStation({
    required this.station,
  });

  final WeatherStation station;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20, top: 0.5, left: 10, right: 10),
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
        ),
        side: BorderSide(
          width: 0.2
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("LOCALIZACION: ${station.location}"),
            Text("TIPO: ${station.stationType.name}"),
            ...textByStation(station)
          ],
        ),
      ),
      ),
    );
  }
}

//CON Poo esto es altamente un switch refactor //Otra cosa.... Pero aquí se queda
//No estoy muy suelta yo con flutter.
List<Widget> textByStation(WeatherStation station){
  List<Widget> stationInformation = [];

  if(station.stationType == StationType.ecowitt){
    stationInformation.add(Text("MAC: ${station.key}"));
    stationInformation.add(Text("AUTH : ${station.auth}"));
  }
  if(station.stationType == StationType.wunderground){
    stationInformation.add(Text("ID: ${station.auth}"));
    stationInformation.add(Text("KEY: ${station.key}"));
  }

  return stationInformation;
}

