import 'dart:developer';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:random_number_generator/base_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      home: const MyHomePage(title: 'Generador Aleatorio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final minimumController = TextEditingController();
  final maximumController = TextEditingController();
  bool withSelectedNumbers = true;
  int _generatedNumber = 0;
  int _previousNumber = 0;

  final List<int> _numbersSelected = [
    // Jocsan
    185,
    518,
    851,
    // Charly
    197,
    530,
    863,
  ];

  Future<void> _generateRandomNumber({bool withSelectedNumbers = false}) async {
    final random = Random();
    int selectedNumber = 0;
    _previousNumber = _generatedNumber;

    if (withSelectedNumbers) {
      do {
        final randomIndex = random.nextInt(_numbersSelected.length - 1);

        selectedNumber = _numbersSelected[randomIndex];
      } while (selectedNumber == _previousNumber);

      final step = selectedNumber > _previousNumber ? 3 : -3;

      log('step: $step');
      log('previousNumber: $_previousNumber');
      log('selectedNumber: $selectedNumber');

      if (step > 0) {
        for (var i = _previousNumber; i <= selectedNumber; i += step) {
          await Future.delayed(const Duration(milliseconds: 1));

          setState(() {
            _generatedNumber = i;
          });
        }
      } else {
        for (var i = _previousNumber; i >= selectedNumber; i += step) {
          await Future.delayed(const Duration(milliseconds: 1));

          setState(() {
            _generatedNumber = i;
          });
        }
      }

      if (selectedNumber != _generatedNumber) {
        setState(() {
          _generatedNumber = selectedNumber;
        });
      }
    } else {
      final minimum = int.tryParse(minimumController.text) ?? 0;
      final maximum = int.tryParse(maximumController.text) ?? 999;

      selectedNumber = random.nextInt(maximum - minimum) + minimum;

      final step = selectedNumber > _previousNumber ? 3 : -3;

      if (step > 0) {
        for (var i = _previousNumber; i <= selectedNumber; i += step) {
          await Future.delayed(const Duration(milliseconds: 2));

          setState(() {
            _generatedNumber = i;
          });
        }
      } else {
        for (var i = _previousNumber; i >= selectedNumber; i += step) {
          await Future.delayed(const Duration(milliseconds: 2));

          setState(() {
            _generatedNumber = i;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color.fromARGB(255, 121, 38, 38),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            log("selectedNumbers: $withSelectedNumbers");
                            setState(() {
                              withSelectedNumbers = !withSelectedNumbers;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(
                              255,
                              238,
                              126,
                              126,
                            ).withAlpha(withSelectedNumbers ? 100 : 20),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(
                              255,
                              238,
                              126,
                              126,
                            ).withAlpha(withSelectedNumbers ? 100 : 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Ingresa el rango de numeros aleatorios que deseas generar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BaseTextfield(
                      width: 150,
                      controller: minimumController,
                      labelText: 'Valor mínimo',
                      keyboardType: TextInputType.number,
                    ),
                    BaseTextfield(
                      width: 150,
                      controller: maximumController,
                      labelText: 'Valor máximo',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                Text(
                  _generatedNumber.toString(),
                  style: TextStyle(fontSize: 120),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () => _generateRandomNumber(
                      withSelectedNumbers: withSelectedNumbers,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome),
                        SizedBox(width: 20),
                        Text('Generar numero'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
