import 'package:el_tiempo_en_galve_app/presentation/screens/home/section_current_time.dart';
import 'package:el_tiempo_en_galve_app/presentation/screens/home/weather_week.dart';
import 'package:el_tiempo_en_galve_app/presentation/screens/home/widget_weather_impact.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_scaffold.dart';

class HomeScreen extends StatelessWidget {
  

  static const name = 'home-screen';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BackgroundGradient(
      
      widget: Scaffold (
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2, top: 2),
              child: Column(
                children: [
                  Text("Galve", style: theme.textTheme.headlineLarge),
                  Text("Lluvioso", style: theme.textTheme.headlineMedium),
                  const WidgetWeatherImpact(
                    //height: screenSize.height / 4.7,
                    height: 180,
                  ),
                  const SizedBox(height: 10),
                  const SectionCurrentTime(
                    //height: screenSize.height / 4
                    height: 200
                  ),
                  const SizedBox(height: 30),
                  const WeatherWeek(
                    //maxHeigth: screenSize.height / 4,
                    maxHeigth: 230,
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}


