import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:formContribuciones/ruta/rutas.dart';
import 'package:formContribuciones/vistas/home.dart';
 
Future<void> main()async{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en','US'),
        const Locale('es','ES')
      ],      
      home: Home(),
      onGenerateRoute: generarRutas,
    );
  }
}