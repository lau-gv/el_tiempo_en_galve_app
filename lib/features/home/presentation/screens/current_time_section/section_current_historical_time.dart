import 'package:el_tiempo_en_galve_app/config/themes/dark_theme.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/current_time_section/historical_today_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'actual_current_data.dart';


//https://blogmarch.com/create-tab-inside-body-widget/

class SectionCurrentHistoricalTime extends StatelessWidget {
  const SectionCurrentHistoricalTime({super.key, 
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
              ActualCurrentData(),
              HistoricalTodayData(),
              //Container(),
            ])
          )
        ])
      );
  }
}