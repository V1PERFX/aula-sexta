import 'package:flutter/material.dart';
import 'package:uni_clima/model/clima_model.dart';

class ClimaWidget extends StatelessWidget {
  const ClimaWidget({ Key? key, required this.climaData}) : super(key: key);

  final ClimaModel climaData;

  String primeiraMaiuscula(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "http://openweathermap.org/img/wn/${climaData.icone}@2x.png",
          fit: BoxFit.fill,
          width: 120,
        ),
        Text(
          "${climaData.temperatura.toStringAsFixed(0)} °C",
          style: const TextStyle(fontSize: 50),
        ),
        Text(
          climaData.descricao,
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 20),
        Text(
          "Mínima do Dia: ${climaData.tempMin.toStringAsFixed(0)} °C",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Máxima do Dia: ${climaData.tempMax.toStringAsFixed(0)} °C",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Sensasão Térmica: ${climaData.sensacaoTermica.toStringAsFixed(0)} °C",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Umidade relativa do ar: ${climaData.umidade}%",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Visibilidade: ${climaData.visibilidade} Km",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Pressão: ${climaData.pressao} hPa",
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}