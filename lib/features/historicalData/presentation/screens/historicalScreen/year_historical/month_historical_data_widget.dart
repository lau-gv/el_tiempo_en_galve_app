import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_month.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/month_enum.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/useCases/year_list_generator.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/monthWidget/month_widget_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/month_historical/rain_month_section.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/month_historical/temperature_month_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearHistoricalDataWidget extends ConsumerWidget {
  const YearHistoricalDataWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final monthDataProvider = ref.watch(monthHistoricalDataProvider);
    final monthDataNotifier = ref.watch(monthHistoricalDataProvider.notifier);

    return Column(children: [
      const SizedBox(height: 10),
      const SizedBox(height: 10),
      Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Para el año:  "),
          ),
          SizedBox(
            width: 115,
            child: DropdownButtonFormField(
              items: getYears(),
              value: monthDataProvider.year,
              onChanged: (value) {
                if (value != null) monthDataNotifier.onYearChange(value);
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
                    .read(monthHistoricalDataProvider.notifier)
                    .onSearch();
              },
              child: const Text("Cambiar mes"))
        ],
      ),
      if (monthDataProvider.visibleHistoricalMonth!.historicalDataDays.isEmpty) const NothingToShow() 
      else ...dataWidgets(monthDataProvider),

    ]);
  }
}

List<DropdownMenuItem<MonthEnum>> getMonths() {
  return MonthEnum.values
      .map((type) => DropdownMenuItem<MonthEnum>(
          value: type,
          child: Text(
            type.name,
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 14),
          )))
      .toList();
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

class _CardHistoricalMonthData extends StatelessWidget {
  final HistoricalAgroupMonth historicalMonth;
  final List<Widget> Function(ThemeData, HistoricalAgroupMonth) childrens;

  const _CardHistoricalMonthData(
      {required this.historicalMonth, required this.childrens});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [...childrens(theme, historicalMonth)],
      ),
    ));
  }
}

List<Widget> dataWidgets(MonthWidgetState monthDataProvider){
  return [
          const SizedBox(height: 10),
      _CardHistoricalMonthData(
          historicalMonth: monthDataProvider.visibleHistoricalMonth!,
          childrens: rainMonthSection),
      const SizedBox(height: 10),
      _CardHistoricalMonthData(
          historicalMonth: monthDataProvider.visibleHistoricalMonth!,
          childrens: temperatureMonthSection),
      const SizedBox(height: 10),
  ];
}

class NothingToShow extends StatefulWidget {
  const NothingToShow({super.key});

  @override
  State<NothingToShow> createState() => _NothingToShowState();
}

class _NothingToShowState extends State<NothingToShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("No hay datos para el mes seleccionado"),
    );
  }
}
