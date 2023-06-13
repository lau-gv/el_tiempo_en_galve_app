import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/today_data_provider.dart';
import 'package:el_tiempo_en_galve_app/config/my_flutter_app_icons.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/current_time_section/data_item_unit.dart';



class MaxHistoricalTodayData extends ConsumerWidget {
  const MaxHistoricalTodayData({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final todayHistoricalProvider = ref.watch(todayHistoricalDataDayProvider);
    final historicalDadatay = todayHistoricalProvider.historicalDataDay;

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 3,
      padding: const EdgeInsets.only(left: 5, right: 4, top: 15),
      children: [
        DataItemUnit(
          icon: MyFlutterApp.rain,
          title: "TOTAL LLUVIA",
          subtitle: "${historicalDadatay != null ? historicalDadatay.acumulateDailyraininmm : ""} mm",
        ),
        DataItemUnit(
          icon: MyFlutterApp.rain,
          title: "INT. LLUVIA",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxRainrateinmm : ""} mm/h",
        ),
        DataItemUnit(
          icon: MyFlutterApp.humidity,
          title: "HUMEDAD",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxHumidity : ""}%",
        ),
        DataItemUnit(
          icon: MyFlutterApp.sunny,
          title: "RADIACION",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxSolarradiation : ""} w/m2",
        ),
        DataItemUnit(
          icon: MyFlutterApp.wind,
          title: "VELOCIDAD VIENTO",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxwindspeedkmh: ""} km/h",
        ),
        DataItemUnit(
          icon: MyFlutterApp.wind,
          title: "EVENTO VIENTO",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxdailygust: ""} km/h",
        ),

        DataItemUnit(
          icon: MyFlutterApp.uvindex,
          title: "UV",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxUv : ""}",
        ),
        DataItemUnit(
          icon: MyFlutterApp.temperature,
          title: "TEMP",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxTemperature : ""} ºC",
        ),
        DataItemUnit(
          icon: MyFlutterApp.pressure,
          title: "PRESION",
          subtitle: "${historicalDadatay != null ? historicalDadatay.maxBaromrelhpa : ""} hpa",
        ),    
      ],
    );
  }
}
class MinHistoricalTodayData extends ConsumerWidget {
  const MinHistoricalTodayData({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final todayHistoricalProvider = ref.watch(todayHistoricalDataDayProvider);
    final historicalDadatay = todayHistoricalProvider.historicalDataDay;

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 3,
      padding: const EdgeInsets.only(left: 5, right: 4, top: 15),
      children: [
        DataItemUnit(
          icon: MyFlutterApp.rain,
          title: "INT. LLUVIA",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minRainrateinmm : ""} mm/h",
        ),
        DataItemUnit(
          icon: MyFlutterApp.humidity,
          title: "HUMEDAD",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minHumidity : ""}%",
        ),
        DataItemUnit(
          icon: MyFlutterApp.sunny,
          title: "RADIACION",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minSolarradiation : ""} w/m2",
        ),
        DataItemUnit(
          icon: MyFlutterApp.wind,
          title: "VELOCIDAD VIENTO",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minwindspeedkmh: ""} km/h",
        ),
        DataItemUnit(
          icon: MyFlutterApp.wind,
          title: "EVENTO VIENTO",
          subtitle: "${historicalDadatay != null ? historicalDadatay.mindailygust: ""} km/h",
        ),

        DataItemUnit(
          icon: MyFlutterApp.uvindex,
          title: "UV",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minUv : ""}",
        ),
        DataItemUnit(
          icon: MyFlutterApp.temperature,
          title: "TEMP",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minTemperature : ""} ºC",
        ),
        DataItemUnit(
          icon: MyFlutterApp.pressure,
          title: "PRESION",
          subtitle: "${historicalDadatay != null ? historicalDadatay.minBaromrelhpa : ""} hpa",
        ),
      ],
    );
  }
}