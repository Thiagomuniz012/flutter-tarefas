import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarefas/servicos/autenticacao.dart';

void main() {
  group('AutenticacaoService', () {
    late AutenticacaoService autenticacaoService;
    late MockFirebaseAuth mockAuth;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      autenticacaoService = AutenticacaoService(auth: mockAuth);
    });

    test('Deve cadastrar um novo usuário', () async {
      final user = await autenticacaoService.cadastrarUsuario('teste@exemplo.com', 'senha123');
      expect(user, isA<User>());
      expect(user?.email, 'teste@exemplo.com');
    });

    test('Deve fazer login com um usuário existente', () async {
      await mockAuth.createUserWithEmailAndPassword(
        email: 'teste@exemplo.com', password: 'senha123');
      final user = await autenticacaoService.fazerLogin('teste@exemplo.com', 'senha123');
      expect(user, isA<User>());
      expect(user?.email, 'teste@exemplo.com');
    });

    test('Deve fazer logout do usuário', () async {
      await autenticacaoService.fazerLogout();
      final user = mockAuth.currentUser;
      expect(user, isNull);
    });
  });
}
