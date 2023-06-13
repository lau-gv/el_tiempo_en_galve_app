import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/currentStationData/current_station_data_provider.dart';
import 'package:el_tiempo_en_galve_app/config/my_flutter_app_icons.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/current_time_section/data_item_unit.dart';



class ActualCurrentData extends ConsumerWidget {
  const ActualCurrentData({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final stationCurrentDataProvider = ref.watch(currentStationDataProvider);
    final stationCurrentData = stationCurrentDataProvider.currentStationData;

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 3,
      padding: const EdgeInsets.only(left: 5, right: 4, top: 15),
      children: [        

        DataItemUnit(
          icon: MyFlutterApp.rain,
          title: "INT.LLUVIA",
          subtitle: "${stationCurrentData != null ? stationCurrentData.rainrateinmm : ""} mm/h",
        ),
        DataItemUnit(
          icon: MyFlutterApp.humidity,
          title: "HUMEDAD",
          subtitle: "${stationCurrentData != null ? stationCurrentData.humidity : ""}%",
        ),
        DataItemUnit(
          icon: MyFlutterApp.sunny,
          title: "RADIACION",
          subtitle: "${stationCurrentData != null ? stationCurrentData.solarradiation : ""} w/m2",
        ),
        DataItemUnit(
          icon: MyFlutterApp.wind,
          title: "VIENTO",
          subtitle: "${stationCurrentData != null ? stationCurrentData.windspeedkmh: ""} km/h",
        ),
        DataItemUnit(
          icon: MyFlutterApp.winddirection,
          title: "DIRECCION",
          subtitle: "${stationCurrentData != null ? stationCurrentData.winddir : ""}º",
        ),
        DataItemUnit(
          icon: MyFlutterApp.uvindex,
          title: "UV",
          subtitle: "${stationCurrentData != null ? stationCurrentData.uv : ""}",
        ),
        DataItemUnit(
          icon: MyFlutterApp.temperature,
          title: "TEMP",
          subtitle: "${stationCurrentData != null ? stationCurrentData.temperature : ""} ºC",
        ),
        DataItemUnit(
          icon: MyFlutterApp.pressure,
          title: "PRESION",
          subtitle: "${stationCurrentData != null ? stationCurrentData.baromrelhpa : ""} hpa",
        ),
      ],
    );
  }
}