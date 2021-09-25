import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "Informe os valores";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculaCombustivelIdeal() {
    double vAlcool = double.parse(alcoolController.text.replaceAll(',', '.'));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = vAlcool / vGasolina;

    // if(proporcao > 0.7) {
    //   _resultado = "Abasteça com Gasolina";
    // } else {
    //   _resultado = "Abasteça com Álcool";
    // }

    setState(() {
      _resultado =
          (proporcao > 0.7) ? "Abasteça com Gasolina" : "Abasteça com Álcool";
    });
  }

  void _reset() {
    setState(() {
      alcoolController.text = "";
      gasolinaController.text = "";
      _resultado = "Informe os valores";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool ou Gasolina"),
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(
            onPressed: () {
              _reset();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.local_gas_station,
                size: 140,
                color: Colors.amber[700],
              ),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value!.isEmpty ? "Informe o valor do Álcool" : null,
                decoration: InputDecoration(
                  labelText: "Valor do Álcool",
                  labelStyle: TextStyle(color: Colors.amber[900]),
                ),
                style: TextStyle(color: Colors.amber[900], fontSize: 26),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value!.isEmpty ? "Informe o valor do Gasolina" : null,
                decoration: InputDecoration(
                  labelText: "Valor do Gasolina",
                  labelStyle: TextStyle(color: Colors.amber[900]),
                ),
                style: TextStyle(color: Colors.amber[900], fontSize: 26),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber[700],
                      textStyle: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculaCombustivelIdeal();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[700], fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
