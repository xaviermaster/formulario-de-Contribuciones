import 'package:flutter/cupertino.dart';
import 'package:formContribuciones/data/opciones.dart';

String generarTexto(List<TextEditingController> textInputsResultados){
  int contador = 0;
    var resultado = '';
    db.forEach((data){
      resultado+=('\t\t\t'+'*'+data['header']+'*'+'\n');
      data['data'].forEach((v){
        resultado+=(v['nombre']+': ${textInputsResultados[contador].text}'+'\n');
        contador++;
      });    

    });
  return resultado;
}