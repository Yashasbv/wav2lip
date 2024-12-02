import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:wav2lip/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting("in", null);
  runApp(const App());
}