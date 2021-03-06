import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formContribuciones/conversiones/conversiones.dart';
import 'package:formContribuciones/data/generar_data.dart';
import 'package:formContribuciones/data/opciones.dart';
import 'package:formContribuciones/manejadores/compartir_archivos.dart';
import 'package:formContribuciones/manejadores/inputFloat.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TextEditingController> controladores = new List(30);
  String dataMes;
  String dataLicencia;
  @override
  void initState() { 
    super.initState();
    dataMes = "Enero";
    dataLicencia ="Aspirante";
    for (var i = 0; i < controladores.length; i++) {
      controladores[i] = new TextEditingController();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aportes Mensuales'),backgroundColor: Color.fromRGBO(63, 63, 156, 1),),
      body: ListView(
        children: _generarData(),
      ),
    );
  }

  List<Widget> _generarData(){
    final List<Widget> widgets = [];
    //LA VARIABLE DB ESTA EN LA CARPETA DATA/OPCIONES.DART
    //DB ES UNA LISTA QUE TIENE MAP, ES DECIR LA LISTA EN CERO TIENE TDO LO QUE VA EN INGLESIA, EL LA LIST EN 1 ORDENACIÓN Y ASÍ....
    final data_from_DataBase = db; 

    //ACA SE ITERA ESA LISTA DE MAP
    data_from_DataBase.forEach((data){
      //SE AGREGA UN WIDGET A LA VARIABLE WIDGETS, NATUERALMENTE ESTE FOR SOLO RECORRERA 3 VECES YA QUE SOLO TENEMOS IGLESIA, ORD Y APORTE
      //ENTONCES POR CADA RECORRIDA GENERAMOS UN HEADER
      widgets.add(generarHeader(data['header']));

      //AHORA SE PROCEDE A -RECORRER LA LISTA "DATA", SI TE FIJAS EN LA LISTA ORIGINAL, TENEMOS UNA LLAVE LLAMADA "DATA" y su valor es un arreglo de mapas
      //Entonces vamos a recorrer la lista de data de la lista original en 0 ES DECIR VAMOS A RECUPERAR LA INFORMACIÓN DE LA IGLESIA, SUS INPUTS..
      data['data'].forEach((v){
        //POR CADA RECORRIDO EN ESA LISTA, (CADA LISTA TIENE UN INPUT) SE GENERA UN NUEVO INPUT
        widgets..add(generarInput(v))
                ..add(SizedBox(height: MediaQuery.of(context).size.height*0.02,));
      });
    });
    widgets.add(Row(
      children: <Widget>[
        RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Color.fromRGBO(63, 63, 156, 1),
            child: Text('Compartir información'),
            onPressed: () async {
              shareText(texto: generarTexto(controladores));
            }),
      ],
    ),);
    return widgets;
  }
  
  Widget generarInput(Map v){
      if (v['tipo']=='Texto') {
        return (crearInputTexto(texto: v['nombre'],enable: v['habilitar'], hintText: v['hintText'],labelText: v['labelText'], controller: controladores[v['controll_id']], icon: v['icon'].toString().toLowerCase()));
      }else if(v['tipo']=='Numerico'){
        return (crearInputNumero(texto: v['nombre'],enable: v['habilitar'], hintText: v['hintText'],labelText: v['labelText'], controller: controladores[v['controll_id']], icon: v['icon'].toString().toLowerCase()));
      }else if(v['tipo']=='Float'){
        return (crearInputDecimal(texto: v['nombre'], enable: v['habilitar'], hintText: v['hintText'],labelText: v['labelText'], controller: controladores[v['controll_id']], icon: v['icon'].toString().toLowerCase()));
      }else if(v['tipo']=='Date'){
        return (crearInputFecha(context: context,hintText: v['hintText'],labelText: v['labelText'], controller: controladores[v['controll_id']], icon: v['icon'].toString().toLowerCase()));
      }else if(v['tipo']=='Combo'){
        return generarComboBox(nombre: v['nombre'], icon: v['icon'].toString().toLowerCase(),controller: controladores[v['controll_id']], dataActual: v['dataActual'], idController: v['controll_id'], dataBox: v['dataCombo']);
      }else{
        return Container();
      }
  }
  queUsar(String dataBox){
    if (dataBox == 'Enero') {
      return dataMes;
    } else {
    }
  }
  Widget generarComboBox({icon, nombre, controller, List dataBox, String dataActual, int idController}){
    Size dimension = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        (generarIcono(icon)),
        SizedBox(width: dimension.width*0.03,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: dimension.width*0.02),
              Text(nombre),
              Container(
                padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<String>(
            value: dataActual=='Enero'?dataMes:dataLicencia,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            onChanged: (String newValue) {
              setState(() {
                dataActual=="Enero"?dataMes = newValue:dataLicencia= newValue;
              });
            },
            items:obtenerItemsComboBox(dataBox)
            ),),
            ],),),
      ],
    );
  }

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
    onChanged: (v){
      double totalAportesDistriales = 0;
      double totalOrdenacion = 0.0;
      for (var i = 6; i < 18; i++) {
        String numActual = controladores[i].text??'0.0';
        totalOrdenacion+= double.parse(numActual==''?'0.0':numActual);
      }
      for (var i = 19; i < 24; i++) {
        String numActual = controladores[i].text??'0.0';
        totalAportesDistriales+= double.parse(numActual==''?'0.0':numActual);
      }
      controladores[18].text = totalOrdenacion.toStringAsFixed(2);
      controladores[24].text = totalAportesDistriales.toStringAsFixed(2);
      
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      hintText: hintText,
      labelText: labelText,
      enabled: enable,
      icon: generarIcono(icon),
    ),
  );
}
  List<DropdownMenuItem<String>> obtenerItemsComboBox(List dataBox) {
    List<DropdownMenuItem<String>> items = new List();
    for (String data in dataBox) {
      items.add(new DropdownMenuItem(
          value: data,
          child: new Text(data)
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
}