import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; // Valor atual exibido na tela
  String _currentInput = ""; // Entrada atual do usuário
  String _operation = ""; // Operação em execução (+, -, *, /)
  double _firstNumber = 0.0; // Primeiro número armazenado

  /// Função para lidar com os botões pressionados
  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Limpa tudo
        _output = "0";
        _currentInput = "";
        _operation = "";
        _firstNumber = 0.0;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        // Define a operação e mostra na tela
        if (_currentInput.isNotEmpty) {
          _firstNumber = double.parse(_currentInput);
        }
        _operation = value;
        _output = "$_firstNumber $_operation "; // Exibe o número e o operador
        _currentInput = "";
      } else if (value == "=") {
        // Realiza o cálculo e exibe o resultado com a operação
        if (_currentInput.isNotEmpty && _operation.isNotEmpty) {
          double secondNumber = double.parse(_currentInput);
          switch (_operation) {
            case "+":
              _output = "$_firstNumber + $secondNumber = ${_firstNumber + secondNumber}";
              break;
            case "-":
              _output = "$_firstNumber - $secondNumber = ${_firstNumber - secondNumber}";
              break;
            case "*":
              _output = "$_firstNumber * $secondNumber = ${_firstNumber * secondNumber}";
              break;
            case "/":
              if (secondNumber != 0) {
                _output = "$_firstNumber / $secondNumber = ${_firstNumber / secondNumber}";
              } else {
                _output = "Erro: Divisão por 0";
              }
              break;
          }
          _currentInput = _output.split(" = ")[1]; // Mantém apenas o resultado após o "="
          _operation = "";
        }
      } else {
        // Adiciona números ao input atual
        if (_output == "0" || _output.startsWith("Erro")) {
          _output = value;
        } else {
          _output += value;
        }
        _currentInput += value;
      }
    });
  }

  /// Função para criar botões
  Widget _buildButton(String value, {Color? color, double fontSize = 24}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora Flutter')),
      body: Column(
        children: [
          // Tela de exibição
          Expanded(
            child: Container(
              color: Colors.black12,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Botões da calculadora
          Column(
            children: [
              // Linha 1: 7 8 9 /
              Row(children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/", color: Colors.orange),
              ]),
              // Linha 2: 4 5 6 *
              Row(children: [
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("*", color: Colors.orange),
              ]),
              // Linha 3: 1 2 3 -
              Row(children: [
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-", color: Colors.orange),
              ]),
              // Linha 4: C 0 = +
              Row(children: [
                _buildButton("C", color: Colors.red),
                _buildButton("0", fontSize: 32),
                _buildButton("=", color: Colors.green),
                _buildButton("+", color: Colors.orange),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
