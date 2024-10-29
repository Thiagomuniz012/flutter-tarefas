import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TarefaService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarTarefa(String titulo, String descricao) async {
    final usuario = _auth.currentUser;
    if (usuario != null) {
      await _firestore
          .collection('usuarios')
          .doc(usuario.uid)
          .collection('tarefas')
          .add({
        'titulo': titulo,
        'descricao': descricao,
        'concluida': false,
        'dataCriacao': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<QuerySnapshot> listarTarefas() {
    final usuario = _auth.currentUser;
    if (usuario != null) {
      return _firestore
          .collection('usuarios')
          .doc(usuario.uid)
          .collection('tarefas')
          .orderBy('dataCriacao', descending: true)
          .snapshots();
    }
    return Stream.empty();
  }

  Future<void> atualizarStatusTarefa(String tarefaId, bool concluida) async {
    final usuario = _auth.currentUser;
    if (usuario != null) {
      await _firestore
          .collection('usuarios')
          .doc(usuario.uid)
          .collection('tarefas')
          .doc(tarefaId)
          .update({
        'concluida': concluida,
      });
    }
  }

  Future<void> atualizarTarefa(String tarefaId, String titulo, String descricao, bool concluida) async {
  final usuario = FirebaseAuth.instance.currentUser;
  if (usuario != null) {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(usuario.uid)
        .collection('tarefas')
        .doc(tarefaId)
        .update({
      'titulo': titulo,
      'descricao': descricao,
      'concluida': concluida,
    });
  }
}

  Future<void> excluirTarefa(String tarefaId) async {
    final usuario = _auth.currentUser;
    if (usuario != null) {
      await _firestore
          .collection('usuarios')
          .doc(usuario.uid)
          .collection('tarefas')
          .doc(tarefaId)
          .delete();
    }
  }
}


