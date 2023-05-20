import 'package:el_tiempo_en_galve_app/config/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeatherWeek extends StatelessWidget {
  
  final double maxHeigth;

  const WeatherWeek({super.key, required this.maxHeigth});

 

  @override
  Widget build(BuildContext context) {


    const hola = [
      CardWeekDay(
        dayName: "LUN",
        dateNumber: "08/05",
        imageUrl: "assets/images/sun.png",
        minmaxT: "18/25",
      ),                  
      CardWeekDay(
        dayName: "MAR",
        dateNumber: "09/05",
        imageUrl: "assets/images/sunwind.png",
        minmaxT: "18/25",
      ),                  
      CardWeekDay(
        dayName: "MIE",
        dateNumber: "10/05",
        imageUrl: "assets/images/suncloud.png",
        minmaxT: "18/25",
      ),                  
      CardWeekDay(
        dayName: "JUE",
        dateNumber: "11/05",
        imageUrl: "assets/images/suncloudrain.png",
        totalRain: "5L",
        minmaxT: "18/25",
      ),                  
      CardWeekDay(
        dayName: "VIE",
        dateNumber: "12/05",
        imageUrl: "assets/images/sun.png",
        minmaxT: "18/25",
      ),                  
      CardWeekDay(
        dayName: "SAB",
        dateNumber: "13/05",
        imageUrl: "assets/images/sun.png",
        minmaxT: "18/25",
      ),                  
      CardWeekDay(
        dayName: "DOM",
        dateNumber: "14/05",
        imageUrl: "assets/images/sun.png",
        minmaxT: "18/25",
      ),                  
  ];  

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
              itemCount: 7,
              itemBuilder: (context, index) {
                return hola[index];
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
  final String minmaxT;
  
  const CardWeekDay({
    super.key, required this.dayName, required this.dateNumber, this.totalRain = "", required this.imageUrl, required this.minmaxT,
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
          padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                Text(minmaxT),
              ],
            ),
        ),
        ),
    );
  }
}