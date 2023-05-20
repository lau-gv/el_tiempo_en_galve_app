import 'package:auto_size_text/auto_size_text.dart';
import 'package:el_tiempo_en_galve_app/config/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/my_flutter_app_icons.dart';


//https://blogmarch.com/create-tab-inside-body-widget/

class SectionCurrentTime extends StatelessWidget {
  const SectionCurrentTime({super.key, 
    required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: height,
      constraints: const BoxConstraints(
        minHeight: 207,
      ),
      decoration: BoxDecoration(
        color: DarkTheme.ultradarkViolet,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
       
          _TabBarWidget(totalheight: height)
          
          
        ],
        )
    );
  }
}

class _TabBarWidget extends StatelessWidget {
  final double totalheight;
  const _TabBarWidget({required this.totalheight});

  @override
  Widget build(BuildContext context) {
    return 
      DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,

        child: Column(
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: totalheight * 0.15,
                width: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35), topLeft: Radius.circular(35)),
                ),
                child: TabBar(
                  onTap: (index) {
                    /*if(index == 2){
                      context.push('/detail-current-data');
                    }*/
                  },              
                  tabs: const [
                    Tab(text: 'Actual'),
                    Tab(text: 'Max/Min'),
                    //Tab(text: 'Ver más'),
                  ],
                ),
              ),
              SizedBox(
                height: totalheight * 0.2,
                child: TextButton(
                  onPressed: (){
                    context.push('/detail-current-data');
                  }, child: const Text('Ver más'))
                ),
            ],
          ),
          SizedBox(
            height: totalheight * 0.8,//height of TabBarView
            child: const TabBarView(children: <Widget>[
              PensarNombre(),
              PensarNombre(),
              //Container(),
            ])
          )
        ])
      );
  }
}

class PensarNombre extends StatelessWidget {
  const PensarNombre({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 3,
      padding: const EdgeInsets.only(left: 5, right: 4, top: 15),
      children: const [
        CurrentDataUnit(
          icon: MyFlutterApp.rain,
          title: "TASA LLUVIA",
          subtitle: "23.8 L",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.humidity,
          title: "HUMEDAD",
          subtitle: "8%",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.sunny,
          title: "RADIACION",
          subtitle: "23.8 L",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.wind,
          title: "VIENTO",
          subtitle: "23.8 L",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.winddirection,
          title: "DIRECCION",
          subtitle: "23.8 L",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.uvindex,
          title: "UV",
          subtitle: "23.8 L",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.temperature,
          title: "TEMP",
          subtitle: "17º L",
        ),
        CurrentDataUnit(
          icon: MyFlutterApp.pressure,
          title: "PRESION",
          subtitle: "valor presion",
        ),
      ],
    );
  }
}

class CurrentDataUnit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  
  const CurrentDataUnit({
    super.key, required this.icon, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 3),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 14),
                minFontSize: 10,
                maxFontSize: 14,
                
              ),
              Text(
                subtitle,
                style: const TextStyle(height: 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}