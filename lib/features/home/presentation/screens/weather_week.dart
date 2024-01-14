import 'package:el_tiempo_en_galve_app/config/themes/dark_theme.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/today_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/week_historical_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../historicalData/domain/entities/historical_data_day.dart';

class WeatherWeek extends ConsumerWidget {
  
  final double maxHeigth;

  const WeatherWeek({super.key, required this.maxHeigth});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayHistoricalDataday = ref.watch(todayHistoricalDataDayProvider).historicalDataDay;
    final lastWeekHistoricalDataDay = ref.watch(weekHistoricalDataProvider).weekHistoricalDataDay;

    final List<CardWeekDay> cardWeekDay = returnCardWeekDayList(lastWeekHistoricalDataDay, todayHistoricalDataday);

    return Column(
      children: [
        const Text("ACUMULADO DE LA SEMANA"),
        const SizedBox(height: 5,),
        Container(
          height: maxHeigth - 20,
          constraints: const BoxConstraints(
            minHeight: 180
          ),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cardWeekDay.length,
              itemBuilder: (context, index) {
                return cardWeekDay[index];
              },                      
            ),
        ),
        
        const SizedBox(height: 5,),
        FilledButton(onPressed: () {
          context.push('/historical-data');
        }, child: const Text('Ver totales')),
      ],
    );
  }
}

class CardWeekDay extends StatelessWidget {
  final String dayName;
  final String dateNumber;
  final String? totalRain;
  final String imageUrl;
  final String maxT;
  final String minT;
  
  const CardWeekDay({
    super.key, required this.dayName, 
    required this.dateNumber, 
    this.totalRain = "", 
    required this.imageUrl, 
    required this.maxT,
    required this.minT,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 65,
        decoration: BoxDecoration(
          color: DarkTheme.secondDarkViolet,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(color:  DarkTheme.grey2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(dayName, style: theme.textTheme.bodyLarge),
                    Text(dateNumber, style: const TextStyle(
                      fontSize: 12 
                    )),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                    Text(totalRain!, style: const TextStyle(color: Colors.blueAccent),),                    
                  ],
                ),
                Text(maxT, style: const TextStyle(height: 1)),
                Text(minT, style: const TextStyle(height: 1)),
              ],
            ),
        ),
        ),
    );
  }
}
List<CardWeekDay> returnCardWeekDayList(
  List<HistoricalDataDay>? lastWeekHistoricalDataDay, 
  HistoricalDataDay? todayHistoricalDataday){
    List<CardWeekDay> cardWeekDay = [];
    
    
    if(lastWeekHistoricalDataDay!=null) addOrUpdatecurrentDay(lastWeekHistoricalDataDay, todayHistoricalDataday);

    lastWeekHistoricalDataDay?.forEach((element) { 
      cardWeekDay.add(
      CardWeekDay(
        dayName: getDayOfWeek(element.year, element.month, element.day),
        dateNumber: "${element.day}/${element.month}",
        imageUrl: determineIcon(element),
        totalRain: "${element.acumulateDailyraininmm > 0 ? element.acumulateDailyraininmm : ""}",
        maxT: "${element.maxTemperature}º",
        minT: "${element.minTemperature}º",
      ),   
    );});
    return cardWeekDay;
}

//¿Esto debería llevarmelo al estado?
void addOrUpdatecurrentDay(List<HistoricalDataDay> lastWeekHistoricalDataDay, HistoricalDataDay? todayHistoricalDataday){
  if(todayHistoricalDataday == null) return;

  if(lastWeekHistoricalDataDay.length > 6) {
    lastWeekHistoricalDataDay.removeLast();
    lastWeekHistoricalDataDay.add(todayHistoricalDataday);
  }else{
    lastWeekHistoricalDataDay.add(todayHistoricalDataday);
  }
}

String determineIcon(HistoricalDataDay historicalDataDay){

  String icon = "";
  if(historicalDataDay.acumulateDailyraininmm > 0){
    icon = "assets/images/suncloudrain.png";
  }else{
    icon = "assets/images/sun.png";
  }

  return icon;
}

String getDayOfWeek(int year, int month, int day) {
  DateTime date = DateTime(year, month, day);
  const List<String> daysOfWeek = [
    'LUN',
    'MAR',
    'MIE',
    'JUE',
    'VIE',
    'SAB',
    'DOM',
  ];

  return daysOfWeek[date.weekday - 1];
}


