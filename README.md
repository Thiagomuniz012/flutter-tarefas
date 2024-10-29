
# Aplicação de Tarefas

## Descrição

Esta é uma aplicação móvel de gerenciamento de tarefas desenvolvida em Flutter. A aplicação permite que os usuários cadastrem, editem, visualizem e excluam tarefas. As funcionalidades de autenticação são gerenciadas com Firebase Authentication, enquanto os dados das tarefas são armazenados no Firestore, o banco de dados NoSQL da Firebase.

A aplicação é útil para quem deseja organizar suas tarefas de maneira prática, podendo marcar uma tarefa como concluída ou ainda editar suas informações conforme necessário.

## Funcionalidades

- **Autenticação de Usuário:** Cadastro, login e logout de usuários usando Firebase Authentication.
- **Cadastro de Tarefas:** Adicione novas tarefas com título e descrição.
- **Edição de Tarefas:** Modifique o título, descrição ou status de conclusão de uma tarefa.
- **Exclusão de Tarefas:** Remova tarefas existentes.
- **Status de Conclusão:** Marque uma tarefa como concluída, com uma indicação visual na lista.

## Estrutura do Código

O código está organizado em diferentes arquivos para separar responsabilidades:

- `autenticacao_service.dart`: Contém a lógica de autenticação (login, cadastro, logout) usando Firebase.
- `tarefa_service.dart`: Gerencia a comunicação com o Firestore para adicionar, atualizar e excluir tarefas.
- `tela_tarefas.dart`: A interface principal onde o usuário interage com suas tarefas. Inclui opções para adicionar, editar e excluir tarefas.
- `test/`: Contém os testes unitários e de widget para verificar a funcionalidade da aplicação.

## Pré-requisitos

- **Flutter**: Certifique-se de ter o Flutter SDK instalado. Você pode verificar a instalação com `flutter --version`.
- **Firebase**: Configure um projeto Firebase e habilite Firebase Authentication e Firestore.

## Configuração do Firebase

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/).
2. Ative Firebase Authentication e escolha o método de autenticação por e-mail/senha.
3. Ative o Firestore como seu banco de dados.
4. Baixe o arquivo `google-services.json` (para Android) e `GoogleService-Info.plist` (para iOS) e coloque-os nas pastas correspondentes:
   - Android: `android/app`
   - iOS: `ios/Runner`

5. No arquivo `pubspec.yaml`, adicione as dependências:

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     firebase_core: latest_version
     firebase_auth: latest_version
     cloud_firestore: latest_version
     provider: latest_version
   ```

6. Execute `flutter pub get` para instalar as dependências.

## Como Rodar a Aplicação

Após configurar o Firebase e instalar as dependências, siga os passos abaixo para rodar a aplicação:

1. **Clone o Repositório:**
   ```bash
   git clone https://github.com/seu-usuario/tarefas.git
   cd tarefas
   ```

2. **Instale as Dependências:**
   ```bash
   flutter pub get
   ```

3. **Inicie o Firebase:**
   Garanta que o Firebase esteja configurado corretamente.

4. **Execute a Aplicação:**
   Para rodar a aplicação em um emulador ou dispositivo conectado, execute:
   ```bash
   flutter run
   ```

## Como Usar

### Tela de Login

1. Ao abrir o aplicativo, você verá a tela de login.
2. Caso não tenha uma conta, clique na opção de cadastro.
3. Insira seu e-mail e senha e clique em "Entrar".

### Tela de Tarefas

Após o login, você será redirecionado para a tela principal de tarefas.

1. **Adicionar Tarefa:**
   - Pressione o botão de "+" no canto inferior direito para adicionar uma nova tarefa.
   - Insira o título e descrição da tarefa e clique em "Adicionar".

2. **Editar Tarefa:**
   - Toque em uma tarefa para visualizar seus detalhes.
   - No diálogo de detalhes, você pode alterar o título, a descrição ou marcar/desmarcar a tarefa como concluída.

3. **Excluir Tarefa:**
   - No diálogo de detalhes, clique em "Excluir" e confirme a exclusão.

4. **Logout:**
   - No canto superior direito da tela, você verá um botão de logout (ícone de saída).
   - Clique para sair da aplicação.

## Estrutura de Dados

As tarefas são armazenadas no Firestore com a seguinte estrutura:

- **Coleção:** `tarefas`
  - **Documento:** Gerado automaticamente com ID único
    - **Campos:**
      - `titulo`: String - O título da tarefa.
      - `descricao`: String - A descrição da tarefa.
      - `concluida`: Boolean - Status de conclusão (true para concluída, false para pendente).

## Testes

A aplicação inclui testes unitários e de widget para garantir a funcionalidade. Os testes estão localizados na pasta `test/`.

Para rodar os testes, utilize:

```bash
flutter test
```

### Testes Disponíveis

1. **Testes de Autenticação (`autenticacao_service_test.dart`):** Verifica o cadastro, login e logout.
2. **Testes de Interface (`tela_tarefas_test.dart`):** Verifica os elementos visuais e interações na `TelaTarefas`.

## Tecnologias Usadas

- **Flutter**: Framework para desenvolvimento de UI.
- **Firebase**: Backend para autenticação e banco de dados.
- **Firestore**: Banco de dados NoSQL em tempo real para armazenamento das tarefas.
- **Provider**: Gerenciamento de estado para Flutter.
- **Mockito**: Biblioteca de mock para testes unitários.
- **flutter_test**: Biblioteca de testes do Flutter.