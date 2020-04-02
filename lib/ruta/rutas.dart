import 'package:flutter/material.dart';
import 'package:formContribuciones/ruta/const_rutas.dart';
import 'package:formContribuciones/vistas/home.dart';
Route<dynamic> generarRutas(RouteSettings settings){
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context)=>Home());
    default:
    return MaterialPageRoute(builder: (context)=>Home());
  }
}