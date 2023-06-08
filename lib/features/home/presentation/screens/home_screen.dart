import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/section_current_time.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/weather_week.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/widget_weather_impact.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/background_gradient.dart';

class HomeScreen extends StatelessWidget {
  

  static const name = 'home-screen';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    final Size screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BackgroundGradient(
      
      widget: Scaffold (
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2),
                child: Column(
                  children: [
                    Text("Galve", style: theme.textTheme.headlineLarge),
                    Text("Lluvioso", style: theme.textTheme.headlineMedium),
                    WidgetWeatherImpact(
                      height: screenSize.height / 4.7,
                      //height: 180,
                    ),
                    const SizedBox(height: 10),
                    SectionCurrentTime(
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


