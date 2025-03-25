# Alpha Learn

Um aplicativo educacional gamificado para crianças da Geração Alpha (5-10 anos).

## Tela de Perfil do Usuário

Esta tela permite que a criança visualize e gerencie seu perfil no aplicativo. Ela inclui:

1. **Seção de cabeçalho**: Mostra o avatar do usuário, nome, idade e nível de progresso no aplicativo.

2. **Estatísticas**: Exibição visual das conquistas do usuário, como estrelas ganhas, atividades completadas e dias de sequência de uso.

3. **Conquistas recentes**: Lista horizontal das badges e prêmios que a criança recebeu recentemente.

4. **Configurações**: Opções para personalizar a experiência do aplicativo, incluindo música, efeitos sonoros, leitura em voz alta e notificações.

5. **Controle dos pais**: Área protegida por senha onde os responsáveis podem configurar limites de tempo, controle de conteúdo e outras configurações.

## Como Testar

Para testar a tela de perfil do aplicativo Alpha Learn, siga estas etapas:

1. **Instale o Flutter**: Certifique-se de ter o Flutter instalado e configurado corretamente.

   ```
   flutter --version
   ```

2. **Instale as dependências**:

   ```
   flutter pub get
   ```

3. **Execute o aplicativo**:

   ```
   flutter run
   ```

4. **Teste as funcionalidades**:
   - Verifique se o avatar, nome e estatísticas do usuário são exibidos corretamente
   - Tente alternar os botões de configurações (música, sons, etc.)
   - Teste a funcionalidade de edição de perfil
   - Verifique se a seção de controle parental funciona corretamente

## Design Visual

A interface é colorida e amigável, com elementos visuais grandes e intuitivos, perfeita para crianças da Geração Alpha. Inclui animações suaves e um design responsivo.

## Estrutura da Tela

```
lib/screens/profile_screen.dart        # Tela principal de perfil
lib/widgets/character_avatar.dart      # Widget de avatar personalizado
lib/widgets/alpha_button.dart          # Botão estilizado para o app
lib/constants/theme.dart               # Definições de cores e temas
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# flutter-teste
