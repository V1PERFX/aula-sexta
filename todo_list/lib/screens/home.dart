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
  late Map<String, dynamic> _ultimoRemovido;
  late int _indiceUltimoremovido;

  @override
  void initState() {
    super.initState();
    _lerDados().then((value) {
      setState(() {
        _todoList = jsonDecode(value!);
      });
    });
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

  Future<void> _recarregaLista() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _todoList.sort((a, b) {
        if (a["realizado"] && !b["realizado"]) return 1;
        if (!a["realizado"] && b["realizado"]) return -1;
        return 0;
      });
      _salvarDados();
    });
  }

  Widget widgetTarefa(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(0.85, 0),
          child: Icon(
            Icons.delete_sweep_outlined,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      child: CheckboxListTile(
        title: Text(_todoList[index]["titulo"]),
        value: _todoList[index]["realizado"],
        checkColor: Theme.of(context).colorScheme.primary,
        activeColor: Theme.of(context).secondaryHeaderColor,
        secondary: CircleAvatar(
          child: Icon(
            _todoList[index]["realizado"] ? Icons.check : Icons.error,
            color: Theme.of(context).colorScheme.primary,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onChanged: (value) {
          setState(() {
            _todoList[index]["realizado"] = value;
            _salvarDados();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _ultimoRemovido = Map.from(_todoList[index]);
          _indiceUltimoremovido = index;
          _todoList.removeAt(index);
          _salvarDados();
        });

        final snack = SnackBar(
          content: Text("Tarefa \"${_ultimoRemovido["Titulo"]}\" apagada!"),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                _todoList.insert(index, _ultimoRemovido);
                _salvarDados();
              });
            },
          ),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      maxLength: 100,
                      decoration:
                          const InputDecoration(labelText: "Nova Tarefa"),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (_todoController.text.isEmpty) {
                          final alerta = SnackBar(
                            content: const Text("Não pode ser vazia!"),
                            duration: const Duration(seconds: 4),
                            action: SnackBarAction(
                              label: "Ok",
                              onPressed: () => ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar(),
                            ),
                          );
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(alerta);
                        } else {
                          _adicionaTarefa();
                        }
                      },
                      child: const Icon(Icons.save),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _recarregaLista,
                child: ListView.builder(
                  itemBuilder: widgetTarefa,
                  itemCount: _todoList.length,
                  padding: const EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
