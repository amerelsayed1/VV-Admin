import 'package:flutter/material.dart';
import 'package:vv_admin/main.dart';


Future<TimeOfDay?> showCustomTimePicker() async {
  return await showTimePicker(
    context: Get.context!, initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
  );

}