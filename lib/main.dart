import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'tela_login.dart';
import 'tela_cadastro.dart';
import 'tela_tarefas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Tarefas',
      initialRoute: '/login',
      routes: {
        '/login': (context) => TelaLogin(),
        '/cadastro': (context) => TelaCadastro(),
        '/tarefas': (context) => TelaTarefas(),
      },
    );
  }
}
