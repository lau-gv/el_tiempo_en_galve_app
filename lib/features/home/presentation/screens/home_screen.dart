import 'package:el_tiempo_en_galve_app/features/historicalData/domain/useCases/weather_conditions_calculador.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/currentStationData/current_station_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/today_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/current_time_section/section_current_historical_time.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/weather_week.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/widget_weather_impact.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/background_gradient.dart';

class HomeScreen extends ConsumerWidget {
  

  static const name = 'home-screen';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentStationData = ref.watch(currentStationDataProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final Size screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BackgroundGradient(
      
      widget: Scaffold (
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(onPressed: (){
              ref.read(currentStationDataProvider.notifier).getCurrentStationData();
              ref.read(currentStationDataProvider.notifier);
              ref.read(todayHistoricalDataDayProvider.notifier).getHistoricalDataDay();
            }, icon: Icon(Icons.refresh_sharp)),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2),
                child: Column(
                  children: [
                    Text("Galve", style: theme.textTheme.headlineLarge),
                    Text(getConditions(currentStationData), style: theme.textTheme.headlineMedium),
                    WidgetWeatherImpact(
                      height: screenSize.height / 4.7,
                      //height: 180,
                    ),
                    const SizedBox(height: 10),
                    SectionCurrentHistoricalTime(
                      height: screenSize.height / 3.8
                      //height: 200
                    ),
                    const SizedBox(height: 10),
                    WeatherWeek(
                      maxHeigth: screenSize.height / 4.5,
                      //maxHeigth: 230,
                    )
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}
/*
enum WeatherCondition {
  sunnyRainy,
  sunny,
  sunnyWithWind,
  sunnyCloudyWithWind,
  sunnyCloudy,
  moonlitRainy,
  moonlit,
  moonlitWithWind,
}*/
String getConditions(CurrentStationDataState? currentStationData){
  
  if(currentStationData == null 
  || currentStationData.currentStationData == null
  || currentStationData.currentDate == null) return "";

  Map<WeatherCondition, String> weatherconditionText = {
    WeatherCondition.sunny : "Soleado",
    WeatherCondition.dayRainy : "Lluvioso",
    WeatherCondition.dayRainyWithWind : "Lluvioso",
    WeatherCondition.sunnyWithWind : "Viento",
    WeatherCondition.sunnyCloudyWithWind : "Viento",
    WeatherCondition.sunnyCloudy : "Posiblemente nublado",
    WeatherCondition.nigthRainy : "Lluvioso",
    WeatherCondition.moonlit : "Noche",
    WeatherCondition.moonlitWithWind : "Viento",
  };
  var weatherConditionCalculator = WeatherConditionCalculator(currentStationData.currentStationData!);
  return weatherconditionText[weatherConditionCalculator.getWeatherCondition(currentStationData.currentDate!)] ?? "";
}



