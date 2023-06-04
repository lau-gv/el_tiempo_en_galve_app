import 'package:el_tiempo_en_galve_app/features/stations/presentation/screens/edit_or_create_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/create_update_station_form_provider.dart';

class CreateStationScreen extends ConsumerWidget {
  static const name = 'create_station';
  const CreateStationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    return EditOrCreateStationScreen(
      onPressedSave: onFormSubmit, 
      createOrEditFormState: ref.watch(createStationFormProvider),
      stationFormNotifier: ref.read(createStationFormProvider.notifier),
      );
  }

  Future<void> onFormSubmit(WidgetRef ref, BuildContext context) async{
    await ref.read(createStationFormProvider.notifier).onFormSubmit();
  }
}
