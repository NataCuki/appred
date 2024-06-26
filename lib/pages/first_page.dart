import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:red/main.dart';
import 'package:red/pages/gcp_services.dart';
import 'package:red/pages/index_page.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<dynamic> _data = [];
  GcpService _gcpService = GcpService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http
        .get(Uri.parse('https://app-gcp-api.onrender.com/bigquery-data'));

    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
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

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              // Container(
              //     decoration: BoxDecoration(
              //         color: const Color.fromARGB(255, 194, 25, 13),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: const Text('Paradas',
              //         style: TextStyle(color: Colors.white, fontSize: 30))),
              ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('horario_tipo_dia'),
                    title: Text(_data[index]['horario_tipo_dia'].toString()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
