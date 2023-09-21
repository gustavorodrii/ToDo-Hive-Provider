import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertodo/meuapp.dart';
import 'package:providertodo/model/feitos_repository.dart';

import 'configs/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    ChangeNotifierProvider(
      create: (context) => FeitosRepository(),
      child: MeuAplicativo(),
    ),
  );
}
