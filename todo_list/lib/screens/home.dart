import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _todoList = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lerDados();
  }

  Future<File> _abreArquivo() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/todoList.json");
  }

  Future<String?> _lerDados() async {
    final arquivo = await _abreArquivo();
    return arquivo.readAsString();
  }

  Future<File> _salvarDados() async {
    String dados = jsonEncode(_todoList);
    final file = await _abreArquivo();
    return file.writeAsString(dados);
  }
  void _adicionaTarefa() {
    setState(() {
      Map<String, dynamic> novoTodo = {};
      novoTodo["titulo"] = _todoController.text;
      novoTodo["realizado"] = false;
      _todoController.text = "";
      _todoList.add(novoTodo);
      _salvarDados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    maxLength: 100,
                    decoration: const InputDecoration(labelText: "Nova Tarefa"),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.save),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
