import 'package:el_tiempo_en_galve_app/features/shared/widgets/custom_dropdown_button_field.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/widgets.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/create_update_station_form_provider.dart';

class EditOrCreateStationScreen extends ConsumerWidget {

  final Future<void> Function(WidgetRef ref, BuildContext context)  onPressedSave;
  final CreateOrEditStationFormState createOrEditFormState;
  final StationFormNotifier stationFormNotifier;

  const EditOrCreateStationScreen({
    super.key,
    required this.onPressedSave,
    required this.createOrEditFormState,
    required this.stationFormNotifier,
    });

  @override
  Widget build(BuildContext context, ref) {

    final theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;

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
                  initialValue: createOrEditFormState.stationName.value,
                  errorMessage: createOrEditFormState.stationName.errorMessage,
                  onChanged: stationFormNotifier.onNameChange,
                ),
                CustomInputText(
                  textLabel: "Localizacion",
                  initialValue: createOrEditFormState.stationLocalization.value,
                  errorMessage: createOrEditFormState.stationLocalization.errorMessage,
                  onChanged: stationFormNotifier.onLocationChange,
                ),
                CustomDropdownButtonFormField<StationType>(
                  textLabel: "Tipo de estacion", 
                  onChanged: stationFormNotifier.changeStationTypeSelected, 
                  items: getStationTypes(), 
                  selectedValue: createOrEditFormState.stationType),
                if(createOrEditFormState.stationType == StationType.ecowitt) CustomInputText(
                  textLabel: "MAC",
                  initialValue: createOrEditFormState.stationMac != null ? createOrEditFormState.stationMac!.value : null,
                  onChanged: stationFormNotifier.onMacChange,
                  errorMessage: createOrEditFormState.stationMac != null 
                    ? createOrEditFormState.stationMac!.errorMessage
                    : "",
                  ),

                FilledButton(
                  onPressed: () async {
                    await onPressedSave(ref, context);
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