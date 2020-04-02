import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formContribuciones/conversiones/conversiones.dart';
import 'package:formContribuciones/manejadores/inputFloat.dart';

Widget generarHeader(String header) {
  return Row(
    children: <Widget>[
      SizedBox(),
      Spacer(),
      Text(
        '$header',
        style: TextStyle(fontSize: 35, color: Color.fromRGBO(63, 63, 156, 1)),
      )
    ],
  );
}

Widget crearInputTexto(
    {texto = '', hintText = '', labelText = '', enable = true, String icon, controller}) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: hintText,
        labelText: labelText,
        enabled: enable,
        icon: generarIcono(icon)),
  );
}

Widget crearInputNumero(
    {texto = '', hintText = '', labelText = '', enable=true, String icon = '', controller}) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      WhitelistingTextInputFormatter.digitsOnly
    ],
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintText: hintText,
      labelText: labelText,
      enabled: enable,
      icon: generarIcono(icon),
    ),
  );
}

Widget crearInputDecimal(
    {texto = '', hintText = '', labelText = '', String icon = '', enable = true, controller}) {
  return TextField(
    controller: controller,
    inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintText: hintText,
      labelText: labelText,
      enabled: enable,
      icon: generarIcono(icon),
    ),
  );
}
  List<DropdownMenuItem<String>> obtenerItemsComboBox(mesesBox) {
    List<DropdownMenuItem<String>> items = new List();
    for (String mes in mesesBox) {
      items.add(new DropdownMenuItem(
          value: mes,
          child: new Text(mes)
      ));
    }
    return items;
  }  
Widget crearInputFecha(
    {hintText = '',
    labelText = '',
    suffixIcon,
    icon,
    @required controller,
    @required context}) {
  return TextField(
    controller: controller,
    enableInteractiveSelection: false,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintText: hintText,
      labelText: labelText,
      icon: generarIcono(icon),
    ),
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
      selecionarFecha(context, controller);
    },
  );
}

selecionarFecha(BuildContext context, TextEditingController controller) async {
  DateTime seleccionada = await showDatePicker(
      context: context,
      locale: Locale('es', 'ES'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2025));
  if (seleccionada != null) {
    controller.text = seleccionada.toString().substring(0, 10);
  }
}