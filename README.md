# vr_curso_app

## Sobre Flutter  Getting Started

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Sobre VR Curso App

O App VR Curso deve realisar cadastro de aluno, curso e matricula .
Seu desenvolvimento será com base em boas práticas, Clean Architecture, SOLID 

### Engenheira:

- Architecture

  - Clean Architecture [(Flutterando)](https://github.com/Flutterando/Clean-Dart)
  - SOLID
  - Test
- State Management
- [BLoC](https://pub.dev/packages/flutter_bloc)
- [Injection e Routes Modular](https://pub.dev/packages/flutter_modular)

### Back-end:

- foi feito com Spring Boot 3 também conta com um desenvolvimento baseado em boas praticas

## Diretrizes do Projeto

### Nomenclatura

- **Diretórios e Arquivos:** `snake_case`
- **Classes:** `PascalCase`
- **Variaveis, funcões e métodos:** `camelCase`
- **Interfaces:** comece com um `I`, por ex. `I`Repository
- **Sufixo:**  exemplo home `_page`/home `_bloc`/Home `Page`
- **Nomeação de Reatividade :**  exemplo home `_bloc`/home `_state`

### Definição de Parâmetros

Seguindo a [Clean Architecture proposta por Flutterando](https://github.com/Flutterando/Clean-Dart#clean-dart-1) obtemos 5 camadas.
Para cada uma foi definido como usar os parâmetros.

- **PRESENTER:**
  - *Reactivity:* Nameado
  - *Controller:* Nameado (Facade Design Pattern)?
  - *UI:* Nameado
- **DOMAIN:** Posicional
- **INFRA**: Posicional
- **EXTERNAL:** Nameado

Para cada camada a regra abaixo deve ser aplicada:

- **Uma sequência de parâmetros usada em mais de um lugar deve fazer parte de uma `classe`**

### Git and GitHub/GitLab/Bitbucket ...

- Commits:
  - [feat, fix, doc, etc.](https://www.conventionalcommits.org/pt-br/v1.0.0/)
  - Examples:

## Autores

Marcos F.C.Rangel

## License

Software proprietário

### Run Project

- flutter runor
- flutter run lib/flavors/main.dart

### Run Build appbundle

- flutter build appbundle lib/main.dart

### Run Build apk

- flutter build apk lib/main.dart

### Run test

- flutter run test
