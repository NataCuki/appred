import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:red/pages/index_page.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // variable para guardar la data de la api
  List<dynamic> _data = [];
  // variable para guardar los datos de los recorridos filtrados por su número
  List _groupedData = [];
  // variable para guardar los números de los recorridos
  List<String> recorridos = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchData();
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> _fetchData() async {
    // muestra el mensage cargando
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('cargando...'),
      ),
    );

    // va a buscar los datos a la api
    final response = await http
        .get(Uri.parse('https://app-gcp-api.onrender.com/bigquery-data'));

    // si la respuesa es exitosa guarda la data
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);

        // esto crea un array con los numeros de los recorridos para el dropdown
        recorridos = _data
            .map((e) => e['negocio_recorrido'].toString())
            .toSet()
            .toList();
      });

      // esto cierra el mensaje de cargando...
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // función que hace la busqueda al seleccionar un recorrido de la lista
  void _onSelectedRecorrido(String? recorrido) {
    setState(() {
      _groupedData =
          _data.where((d) => d['negocio_recorrido'] == recorrido).toList();
    });
  }

  // función que transforma el color que viene de la api a valor HEX
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IndexPage()));
          },
        ),
        centerTitle: true,
        title: const Text(
          'Bienvenido a Mi App Red',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 194, 25, 13),
      ),

      // cuerpo
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // buscador de recorridos
            DropdownSearch<String>(
              items: recorridos,
              popupProps: const PopupProps.menu(
                title: Text('Ingresa el recorrido..'),
                showSearchBox: true,
                fit: FlexFit.loose,
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                label: Text('Recorrido'),
                hintText: 'Busca tu recorrido...',
              )),
              onChanged: (String? value) => _onSelectedRecorrido(value),
            ),
            // separador
            const SizedBox(height: 30),
            // acá se cargan los horarios de los recorridos
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _groupedData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: hexToColor(_groupedData[index]['negocio_color']),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Dia(s) ${_groupedData[index]['horario_tipo_dia']}"),
                        Text(
                            'horario_inicio ${_groupedData[index]['horario_inicio']}'),
                        Text(
                            'horario_fin ${_groupedData[index]['horario_fin']}'),
                        Text(
                            'horario_sentido: ${_groupedData[index]['horario_sentido']}'),
                      ],
                    ),
                  );
                },
                // esto crea una linea separadora
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            // Container(
            //     decoration: BoxDecoration(
            //         color: const Color.fromARGB(255, 194, 25, 13),
            //         borderRadius: BorderRadius.circular(10)),
            //     child: const Text('Horarios',
            //         style: TextStyle(color: Colors.white, fontSize: 30))),
            // const SizedBox(
            //   height: 20,
            // ),
            // Container(
            //     decoration: BoxDecoration(
            //         color: const Color.fromARGB(255, 194, 25, 13),
            //         borderRadius: BorderRadius.circular(10)),
            //     child: const Text('Recorridos',
            //         style: TextStyle(color: Colors.white, fontSize: 30))),
            // const SizedBox(
            //   height: 20,
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _groupedData.length,
            //     itemBuilder: (context, index) {
            //       String recorrido = _groupedData.keys.elementAt(index);
            //       List items = _groupedData[recorrido];
            //       print('items length');
            //       print(items.length);
            //       return Column(
            //         children: [
            //           Expanded(
            //             child: ListView.builder(
            //               itemCount: items.length,
            //               itemBuilder: (context, index) {
            //                 return Column(
            //                   children: [
            //                     Text('horario_tipo_dia: ' +
            //                         items[index]['horario_tipo_dia']),
            //                   ],
            //                 );
            //               },
            //               // leading: const Text('horario_tipo_dia'),
            //               // title: Text(_data[index]['horario_tipo_dia'].toString()),
            //               // title: Text(_data[index]['horario_tipo_dia'].toString()),
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
