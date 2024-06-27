import 'package:flutter/material.dart';
import 'package:red/pages/first_page.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logored.png', // Ruta de la imagen en tu proyecto
              width: 150, // Ancho de la imagen
              height: 150, // Alto de la imagen
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/otrobusrojo.gif'),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FirstPage()));
                //aqui va el comportamiento del click o tap
              },
              // ignore: prefer_const_constructors
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 194, 25, 13),
                    borderRadius: BorderRadius.circular(25)),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Súbete a Red',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/duoc_logo.jpeg',
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
