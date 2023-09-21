import 'package:flutter/material.dart';
import 'package:providertodo/pages/page_view.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageViewPage(),
    );
  }
}
