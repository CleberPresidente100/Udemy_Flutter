import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MeuApp(),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int contador = 0;
  final int lotacaoEstabelecimento = 20;

  void incrementaContador() {
    setState(() {
      contador ++;
    });
    print(contador);
  }

  void decrementaContador() {
    setState(() {
      contador --;
    });
    print(contador);
  }

  bool get isEmpty => contador == 0;
  bool get isFull => contador == lotacaoEstabelecimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Crown.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFull ? 'LOTADO !!!' : 'Cleber Presidente 100%',
              style: TextStyle(
                fontSize: 26,
                color: isFull ? Colors.red : Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 100,
                bottom: 100,
              ),
              child: Text(
                '$contador',
                style: TextStyle(
                  fontSize: 100,
                  color: isFull ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isFull ? null : incrementaContador,
                  style: TextButton.styleFrom(
                    backgroundColor: isFull ? Colors.grey : Colors.white,
                    fixedSize: const Size(100, 100),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Entrou',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 64,
                ),
                TextButton(
                  onPressed: isEmpty ? null : decrementaContador,
                  style: TextButton.styleFrom(
                    backgroundColor: isEmpty ? Colors.grey : Colors.white,
                    fixedSize: const Size(100, 100),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Saiu',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
