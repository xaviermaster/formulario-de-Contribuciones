import 'package:flutter/material.dart';

//En base a una extensión de icono devuelvo el icono
Map<String, dynamic> iconos= {
  "text_fields": Icon(Icons.text_fields,color: Colors.black,),
  "monetization_on": Icon(Icons.monetization_on, color: Colors.black,),
  "calendar_today": Icon(Icons.calendar_today, color: Colors.black,),
};

 generarIcono(icono){
   return iconos[icono];
}
