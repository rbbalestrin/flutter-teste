import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/theme.dart';
import '../widgets/alpha_button.dart';
import '../widgets/character_avatar.dart';
import 'stories_screen.dart';
import 'interactive_story_screen.dart';

class StoryDetailScreen extends StatelessWidget {
  final StoryData story;
  
  const StoryDetailScreen({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Imagem de capa com AppBar transparente sobreposta
          _buildAppBar(context),
          
          // Conteúdo da história
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildInfoSection(),
                      const SizedBox(height: 24),
                      _buildDescriptionSection(),
                      const SizedBox(height: 24),
                      _buildCharactersSection(),
                      const SizedBox(height: 24),
                      _buildPreviewSection(context),
                      const SizedBox(height: 40),
                      _buildReadButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: _getCategoryColor(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem de fundo
            Image.asset(
              story.imagePath,
              fit: BoxFit.cover,
            ),
            // Overlay gradiente para melhorar a visibilidade do texto
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            // Tag de categoria
            Positioned(
              top: 100,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getCategoryColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  story.categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, color: Colors.white),
          ),
          onPressed: () {
            // Adicionar a lista de favoritos
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Adicionado aos favoritos!'),
                backgroundColor: AlphaColors.success,
              ),
            );
          },
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {
            // Compartilhar com amigos
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
  
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          story.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: AlphaColors.warning,
              size: 20,
            ),
            const SizedBox(width: 4),
            const Text(
              '4.8',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AlphaColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(240 avaliações)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoCard(
          icon: Icons.access_time,
          title: 'Duração',
          value: story.duration,
          color: AlphaColors.primary,
        ),
        _buildInfoCard(
          icon: Icons.child_care,
          title: 'Idade',
          value: story.recommendedAge,
          color: AlphaColors.secondary,
        ),
        _buildInfoCard(
          icon: Icons.menu_book,
          title: 'Páginas',
          value: '12',
          color: AlphaColors.tertiary,
        ),
      ],
    );
  }
  
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AlphaColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre a história',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          story.description + '\n\n'
          'Durante esta aventura, as crianças ajudarão personagens, resolverão quebra-cabeças, '
          'aprenderão sobre amizade e descobrirão o valor da preservação da natureza. '
          'Uma história interativa com escolhas que influenciam o desenrolar da narrativa!',
          style: const TextStyle(
            fontSize: 15,
            color: AlphaColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCharactersSection() {
    // Lista de personagens da história (simulação)
    final characters = [
      {'name': 'Tito', 'image': 'assets/images/character1.png'},
      {'name': 'Lili', 'image': 'assets/images/character2.png'},
      {'name': 'Duda', 'image': 'assets/images/character3.png'},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personagens',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            characters.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CharacterAvatar(
                name: characters[index]['name'],
                imagePath: characters[index]['image'],
                size: 70,
                borderColor: _getCategoryColor(),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPreviewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prévia',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Lottie.asset(
              'assets/animations/story_preview.json',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildReadButton(BuildContext context) {
    return AlphaButton(
      label: story.progress > 0 ? 'Continuar Lendo' : 'Iniciar Leitura',
      icon: story.progress > 0 ? Icons.play_arrow : Icons.book,
      isLarge: true,
      color: _getCategoryColor(),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InteractiveStoryScreen(story: story),
          ),
        );
      },
    );
  }
  
  Color _getCategoryColor() {
    switch (story.categoryName) {
      case 'Aventura':
        return AlphaColors.primary;
      case 'Animais':
        return AlphaColors.secondary;
      case 'Ciências':
        return AlphaColors.tertiary;
      case 'Espaço':
        return const Color(0xFF5B54FA);
      case 'Natureza':
        return AlphaColors.success;
      case 'Amizade':
        return const Color(0xFFFF8FA3);
      default:
        return AlphaColors.primary;
    }
  }
} 