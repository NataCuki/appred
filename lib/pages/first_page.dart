import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:red/main.dart';
import 'package:red/pages/index_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 194, 25, 13),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Horarios',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 194, 25, 13),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Recorridos',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 194, 25, 13),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Paradas',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
            ],
          ),
        ),
      ),
    );
  }
}
