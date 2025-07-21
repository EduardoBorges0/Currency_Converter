# 🪙 UCypto - Seu verificador das suas criptomoedas favoritas

Esse projeto foi feito com intuito de aprender mais sobre Flutter.
## 🚀 Tecnologias utilizadas

- Flutter
- SharedPreferences para persistência de dados
- Dio para requisições HTTP
- Firebase Authentication para autenticação de usuários
- Cloud Firestore para armazenamento de dados em nuvem
- BloC para gerenciamento de estado
- Navigator para navegação entre telas
- MVVM + Clean Architecture + Repository Pattern
- Git para versionamento de código

---

## ✅ Pré-requisitos

Antes de rodar o projeto, você precisará ter instalado na sua máquina:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio?hl=pt-br)
- [Git](https://git-scm.com/)

---

## ⚙️ Configuração do banco de dados

1. Instale o Android Studio mais recente
2. Instale o Flutter SDK e adicione o caminho do flutter/bin à variável de ambiente PATH.
3. Clone o repositório
   git clone https://github.com/EduardoBorges0/UCrypto.git
   cd seu-repositorio
4. Instale as dependências do projeto
  ```bash
  flutter pub get
  ```
5. Configure o Firebase:
   - Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
   - Adicione um aplicativo Android ao seu projeto Firebase
   - Baixe o arquivo `google-services.json` e coloque na pasta `android/app/`
   - Siga as instruções para configurar o Firebase Authentication e Firestore
   
6. Rode o app
   ```bash
   flutter run
   ```
   
👨‍💻 Autor  </br>
Desenvolvido por Eduardo Borges </br>
🔗 LinkedIn: https://www.linkedin.com/in/eduardoo-borges/