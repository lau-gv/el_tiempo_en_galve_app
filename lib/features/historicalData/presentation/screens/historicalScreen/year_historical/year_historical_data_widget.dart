import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_year.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/useCases/year_list_generator.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/yearWidget/year_widget_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/year_historical/rain_year_section.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/year_historical/temperature_year_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearHistoricalDataWidget extends ConsumerWidget {
  const YearHistoricalDataWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final yearDataProvider = ref.watch(yearHistoricalDataProvider);
    final yearDataNotifier = ref.watch(yearHistoricalDataProvider.notifier);

    return Column(children: [
      const SizedBox(height: 10),
      const SizedBox(height: 10),
      Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Para el año:  "),
          ),
          SizedBox(
            width: 85,
            child: DropdownButtonFormField(
              items: getYears(),
              value: yearDataProvider.year,
              onChanged: (value) {
                if (value != null) yearDataNotifier.onYearChange(value);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 9),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const SizedBox(width: 20),
          FilledButton(
              onPressed: () async {
                await ref
                    .read(yearHistoricalDataProvider.notifier)
                    .onSearch();
              },
              child: const Text("Cambiar año"))
        ],
      ),
      if (yearDataProvider.historicalYears.isEmpty) const NothingToShow() 
      else ...dataWidgets(yearDataProvider),

    ]);
  }
}

List<DropdownMenuItem<int>> getYears() {
  final yearsGenerator = YearListGenerator().years;

  return yearsGenerator
      .map((type) => DropdownMenuItem<int>(
          value: type,
          child: Text(
            type.toString(),
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 14),
          )))
      .toList();
}

class _CardHistoricalYearData extends StatelessWidget {
  final HistoricalAgroupYear historicalYear;
  final List<Widget> Function(ThemeData, HistoricalAgroupYear) childrens;

  const _CardHistoricalYearData(
    {required this.historicalYear, required this.childrens});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [...childrens(theme, historicalYear)],
      ),
    ));
  }
}

List<Widget> dataWidgets(YearWidgetState yearDataProvider){
  return [
          const SizedBox(height: 10),
      _CardHistoricalYearData(
          historicalYear: yearDataProvider.visibleHistoricalYear!,
          childrens: rainYearSection),
      const SizedBox(height: 10),
      _CardHistoricalYearData(
          historicalYear: yearDataProvider.visibleHistoricalYear!,
          childrens: temperatureYearSection),
      const SizedBox(height: 10),
  ];
}

class NothingToShow extends StatelessWidget {
  const NothingToShow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 50,
      child: Card(
        child: Center(child: Text("No hay datos para el año seleccionado"))),
    );
  }
}
