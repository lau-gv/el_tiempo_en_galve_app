import 'package:el_tiempo_en_galve_app/features/shared/widgets/custom_dropdown_button_field.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/widgets.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/create_station_form_provider.dart';

class CreateStationScreen extends ConsumerWidget {
  static const name = 'create_station';
  const CreateStationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;
    final createForm = ref.watch(createStationFormProvider);

    return  BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: screenSize.height * 0.2,
                  child: Image.asset(
                    'assets/images/logo/station_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Guardar estación",
                  style: theme.textTheme.displayMedium,
                ),
                const SizedBox(height: 20,),
                CustomInputText(
                  textLabel: "Nombre",
                  errorMessage: createForm.stationName.errorMessage,
                  onChanged: ref.read(createStationFormProvider.notifier).onNameChange,
                ),
                CustomInputText(
                  textLabel: "Localizacion",
                  errorMessage: createForm.stationLocalization.errorMessage,
                  onChanged: ref.read(createStationFormProvider.notifier).onLocationChange,
                ),
                CustomDropdownButtonFormField<StationType>(
                  textLabel: "Tipo de estacion", 
                  onChanged: ref.read(createStationFormProvider.notifier).changeStationTypeSelected, 
                  items: getStationTypes(), 
                  selectedValue: createForm.stationType),
                if(createForm.stationType == StationType.ecowitt) CustomInputText(
                  textLabel: "MAC",
                  onChanged: ref.read(createStationFormProvider.notifier).onMacChange,
                  errorMessage: createForm.stationMac != null 
                    ? createForm.stationMac!.errorMessage
                    : "",
                  ),

                FilledButton(
                  onPressed: () async {
                    await ref.read(createStationFormProvider.notifier).onFormSubmit();
                  },
                  child: const Text('GUARDAR', style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
List<DropdownMenuItem<StationType>> getStationTypes() {
  return StationType.values.map((type) => 
    DropdownMenuItem<StationType>(
      value: type,
      child: Text(type.name))).toList();
 }