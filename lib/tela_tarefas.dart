import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarefas/servicos/autenticacao.dart';
import 'servicos/tarefa_service.dart';

class TelaTarefas extends StatelessWidget {
  final TarefaService _tarefaService = TarefaService();
  final AutenticacaoService _autenticacaoService = AutenticacaoService();

  Future<void> adicionarTarefaDialog(BuildContext context) async {
    final TextEditingController controladorTitulo = TextEditingController();
    final TextEditingController controladorDescricao = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Adicionar Tarefa",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controladorTitulo,
                  decoration: InputDecoration(
                    labelText: "Título",
                    prefixIcon: Icon(Icons.title, color: Colors.blueGrey[700]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: controladorDescricao,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    prefixIcon:
                        Icon(Icons.description, color: Colors.blueGrey[700]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar",
                      style: TextStyle(color: Colors.grey[600])),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    await _tarefaService.adicionarTarefa(
                      controladorTitulo.text.trim(),
                      controladorDescricao.text.trim(),
                    );
                    Navigator.pop(context);
                  },
                  child: Text("Adicionar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> exibirDetalhesTarefaDialog(BuildContext context, String tarefaId,
      String titulo, String descricao, bool concluida) async {
    final TextEditingController controladorTitulo =
        TextEditingController(text: titulo);
    final TextEditingController controladorDescricao =
        TextEditingController(text: descricao);
    bool statusConcluida = concluida;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                "Detalhes da Tarefa",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controladorTitulo,
                      decoration: InputDecoration(
                        labelText: "Título",
                        prefixIcon:
                            Icon(Icons.title, color: Colors.blueGrey[700]),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controladorDescricao,
                      decoration: InputDecoration(
                        labelText: "Descrição",
                        prefixIcon: Icon(Icons.description,
                            color: Colors.blueGrey[700]),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text("Concluída:",
                            style: TextStyle(
                                fontSize: 16, color: Colors.blueGrey[700])),
                        Spacer(),
                        Switch(
                          value: statusConcluida,
                          onChanged: (valor) {
                            setState(() {
                              statusConcluida = valor;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        await _tarefaService.atualizarTarefa(
                          tarefaId,
                          controladorTitulo.text.trim(),
                          controladorDescricao.text.trim(),
                          statusConcluida,
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Salvar"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        bool? confirmar = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Excluir Tarefa"),
                              content: Text(
                                  "Tem certeza que deseja excluir esta tarefa?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text("Cancelar",
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text("Excluir"),
                                ),
                              ],
                            );
                          },
                        );
                        if (confirmar == true) {
                          await _tarefaService.excluirTarefa(tarefaId);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Excluir"),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _autenticacaoService.fazerLogout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tarefaService.listarTarefas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma tarefa encontrada",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.all(8),
            children: snapshot.data!.docs.map((documento) {
              Map<String, dynamic> dados =
                  documento.data()! as Map<String, dynamic>;
              return Card(
                color: dados['concluida']
                    ? Colors.green[100]
                    : Colors.blueGrey[100],
                margin: EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    dados['titulo'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: dados['concluida']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    dados['descricao'],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      decoration: dados['concluida']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      dados['concluida']
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: dados['concluida'] ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      _tarefaService.atualizarStatusTarefa(
                          documento.id, !dados['concluida']);
                    },
                  ),
                  onTap: () {
                    exibirDetalhesTarefaDialog(
                      context,
                      documento.id,
                      dados['titulo'],
                      dados['descricao'],
                      dados['concluida'],
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => adicionarTarefaDialog(context),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
