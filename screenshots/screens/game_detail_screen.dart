import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/theme.dart';
import '../widgets/alpha_button.dart';
import 'games_screen.dart';

class GameDetailScreen extends StatelessWidget {
  final GameData game;
  
  const GameDetailScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar com imagem do jogo
          _buildAppBar(context),
          
          // Conteúdo
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
                      _buildInfoRow(),
                      const SizedBox(height: 24),
                      _buildSkillsList(),
                      const SizedBox(height: 24),
                      _buildDescriptionSection(),
                      const SizedBox(height: 32),
                      _buildHowToPlaySection(),
                      const SizedBox(height: 40),
                      _buildPlayButton(context),
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
      expandedHeight: 250,
      pinned: true,
      backgroundColor: _getCategoryColor(game.categoryName),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem de fundo
            Image.asset(
              game.imagePath,
              fit: BoxFit.cover,
            ),
            // Overlay gradiente
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
            // Adicionar aos favoritos
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Adicionado aos favoritos!'),
                backgroundColor: AlphaColors.success,
              ),
            );
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
          game.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(game.categoryName).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                game.categoryName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryColor(game.categoryName),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.star,
              color: AlphaColors.warning,
              size: 18,
            ),
            const SizedBox(width: 4),
            const Text(
              '4.8',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AlphaColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(210 jogadores)',
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
  
  Widget _buildInfoRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AlphaColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            icon: Icons.child_care,
            label: 'Idade',
            value: game.recommendedAge,
          ),
          _buildInfoItem(
            icon: Icons.access_time,
            label: 'Duração',
            value: game.duration,
          ),
          _buildInfoItem(
            icon: Icons.emoji_events,
            label: 'Pontos',
            value: '50',
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final color = _getCategoryColor(game.categoryName);
    
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSkillsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades Desenvolvidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: game.skills.map((skill) => _buildSkillChip(skill)).toList(),
        ),
      ],
    );
  }
  
  Widget _buildSkillChip(String skill) {
    final List<Color> skillColors = [
      AlphaColors.primary,
      AlphaColors.secondary,
      AlphaColors.tertiary,
      AlphaColors.success,
    ];
    
    // Determinando a cor pelo índice da habilidade na lista
    final index = game.skills.indexOf(skill) % skillColors.length;
    final color = skillColors[index];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getSkillIcon(skill),
            color: color,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            skill,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
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
          'Sobre o Jogo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${game.description}\n\n'
          'Este jogo foi projetado para ajudar crianças a desenvolverem habilidades de '
          '${game.skills.join(' e ')} de forma divertida e interativa. '
          'Com gráficos coloridos e sons divertidos, as crianças vão aprender enquanto se divertem!',
          style: const TextStyle(
            fontSize: 15,
            color: AlphaColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
  
  Widget _buildHowToPlaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Como Jogar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AlphaColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Lottie.asset(
                'assets/animations/how_to_play.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHowToPlayStep(
                    '1. Toque nos números que somam 10',
                    Icons.touch_app,
                  ),
                  const SizedBox(height: 8),
                  _buildHowToPlayStep(
                    '2. Complete todos os pares',
                    Icons.check_circle_outline,
                  ),
                  const SizedBox(height: 8),
                  _buildHowToPlayStep(
                    '3. Desbloqueie o baú do tesouro',
                    Icons.lock_open,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildHowToPlayStep(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: _getCategoryColor(game.categoryName),
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AlphaColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlayButton(BuildContext context) {
    return AlphaButton(
      label: game.progress > 0 ? 'Continuar Jogando' : 'Iniciar Jogo',
      icon: Icons.play_arrow,
      isLarge: true,
      color: _getCategoryColor(game.categoryName),
      onPressed: () {
        // Em um app real, navegaria para o jogo
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => _buildGamePreview(context),
        );
      },
    );
  }
  
  Widget _buildGamePreview(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          // Barra de arrastar
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          
          // Título
          Text(
            game.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AlphaColors.textPrimary,
            ),
          ),
          
          // Prévia do jogo - Aqui seria implementado o jogo real
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Lottie.asset(
                        'assets/animations/game_preview.json',
                        repeat: true,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Esta é uma prévia do jogo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AlphaColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Em um aplicativo completo, o jogo seria implementado aqui.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AlphaColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AlphaButton(
                      label: 'Voltar',
                      color: AlphaColors.primary,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getSkillIcon(String skill) {
    switch (skill.toLowerCase()) {
      case 'adição':
      case 'subtração':
      case 'matemática':
        return Icons.calculate;
      case 'vocabulário':
      case 'ortografia':
        return Icons.text_fields;
      case 'memória':
        return Icons.psychology;
      case 'classificação':
        return Icons.category;
      case 'espacialidade':
      case 'geografia':
        return Icons.map;
      case 'criatividade':
        return Icons.brush;
      case 'reconhecimento de padrões':
        return Icons.grid_on;
      case 'ritmo':
      case 'coordenação':
        return Icons.music_note;
      default:
        return Icons.star;
    }
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Matemática':
        return AlphaColors.primary;
      case 'Português':
        return AlphaColors.secondary;
      case 'Ciências':
        return AlphaColors.tertiary;
      case 'Geografia':
        return const Color(0xFF5B54FA);
      case 'Arte':
        return AlphaColors.success;
      case 'Música':
        return const Color(0xFFFF8FA3);
      default:
        return AlphaColors.primary;
    }
  }
}