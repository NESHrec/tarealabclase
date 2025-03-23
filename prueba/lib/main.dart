import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Pasos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _steps = 0; // Contador de pasos
  int _dailyGoal = 1000; // Meta diaria de pasos
  final TextEditingController _goalController = TextEditingController();

  void _incrementSteps() {
    setState(() {
      _steps++;
    });
  }

  void _decrementSteps() {
    setState(() {
      if (_steps > 0) _steps--;
    });
  }

  void _setDailyGoal() {
    setState(() {
      _dailyGoal = int.tryParse(_goalController.text) ?? _dailyGoal;
      _goalController.clear(); // Limpiar el campo de texto
    });
  }

  void _resetSteps() {
    setState(() {
      _steps = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = _steps / _dailyGoal; // Progreso hacia la meta
    Color progressColor = progress >= 1.0 ? Colors.green : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contador de Pasos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pasos Actuales: $_steps',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            SizedBox(height: 20),
            Text(
              'Meta Diaria: $_dailyGoal pasos',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                labelText: 'Ingresa tu meta diaria',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _setDailyGoal,
              child: Text('Establecer Meta'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _incrementSteps,
                  child: Text('+1 Paso'),
                ),
                ElevatedButton(
                  onPressed: _decrementSteps,
                  child: Text('-1 Paso'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetSteps,
              child: Text('Reiniciar Contador'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}