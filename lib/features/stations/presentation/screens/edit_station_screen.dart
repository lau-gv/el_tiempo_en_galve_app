import 'package:el_tiempo_en_galve_app/features/stations/presentation/screens/edit_or_create_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/create_update_station_form_provider.dart';

class EditStationScreen extends ConsumerWidget {
  static const name = 'edit_station';
  final String stationId;

  const EditStationScreen({
    super.key,
    required this.stationId,
    });

  @override
  Widget build(BuildContext context, ref) {
    
    return EditOrCreateStationScreen(
      onPressedSave: onFormSubmit, 
      createOrEditFormState: ref.watch(updateStationFormProvider(stationId)),
      stationFormNotifier: ref.read(updateStationFormProvider(stationId).notifier),
      );
  }

  Future<void> onFormSubmit(WidgetRef ref, BuildContext context) async{
    await ref.read(updateStationFormProvider(stationId).notifier).onFormSubmit();
  }
}
