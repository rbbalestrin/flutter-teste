import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../widgets/character_avatar.dart';
import '../widgets/alpha_button.dart';
import '../widgets/learning_card.dart';
import 'stories_screen.dart';
import 'games_screen.dart';
import 'rewards_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dados simulados para o progresso do estudante
  final String _studentName = "Letícia";
  final int _studentAge = 7;
  final int _level = 3;
  final int _currentXP = 70;
  final int _totalXP = 100;
  final int _streakDays = 5;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDailyChallengeCard(),
                    const SizedBox(height: 24),
                    _buildMenuTitle('Continue Aprendendo'),
                    const SizedBox(height: 8),
                    _buildContinueLearningSection(),
                    const SizedBox(height: 24),
                    _buildMenuTitle('Atividades'),
                    const SizedBox(height: 8),
                    _buildActivitiesGrid(),
                    const SizedBox(height: 24),
                    _buildMenuTitle('Conquistas Recentes'),
                    const SizedBox(height: 8),
                    _buildRecentAchievements(),
                  ],
                ),
              ),
            ),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar do usuário
          CharacterAvatar(
            imagePath: 'assets/images/avatar.png',
            size: 60,
            withBorder: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          
          const SizedBox(width: 12),
          
          // Nome e nível
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, $_studentName!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AlphaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AlphaColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Nível $_level',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _currentXP / _totalXP,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AlphaColors.secondary),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_currentXP/$_totalXP XP',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AlphaColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Streak de dias
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AlphaColors.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: AlphaColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '$_streakDays',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AlphaColors.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDailyChallengeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AlphaColors.primary, AlphaColors.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AlphaColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Desafio do dia',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Complete 2 histórias hoje e ganhe uma recompensa especial!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AlphaColors.success,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '0/2 completado',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AlphaColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AlphaButton(
                label: 'Iniciar',
                icon: Icons.play_arrow,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StoriesScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navegar para ver todos
          },
          child: const Text(
            'Ver todos',
            style: TextStyle(
              color: AlphaColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildContinueLearningSection() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Atividade de história interativa
          LearningCard(
            title: 'A Floresta Encantada',
            description: 'Continue sua aventura no capítulo 3',
            imagePath: 'assets/images/forest_story.png',
            color: AlphaColors.primary,
            progress: 0.6,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoriesScreen()),
              );
            },
          ),
          // Jogo educacional
          LearningCard(
            title: 'Caça ao Tesouro Matemático',
            description: 'Você completou 4 de 10 desafios',
            imagePath: 'assets/images/math_game.png',
            color: AlphaColors.secondary,
            progress: 0.4,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamesScreen()),
              );
            },
          ),
          // Outra atividade
          LearningCard(
            title: 'Soletrando',
            description: 'Vamos praticar mais palavras novas',
            imagePath: 'assets/images/spelling.png',
            color: AlphaColors.tertiary,
            progress: 0.3,
            onTap: () {
              // Navegar para o jogo específico
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivitiesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildActivityCard(
          title: 'Histórias',
          icon: Icons.book,
          color: AlphaColors.primary,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StoriesScreen()),
            );
          },
        ),
        _buildActivityCard(
          title: 'Jogos',
          icon: Icons.games,
          color: AlphaColors.secondary,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamesScreen()),
            );
          },
        ),
        _buildActivityCard(
          title: 'Desenhos',
          icon: Icons.brush,
          color: AlphaColors.tertiary,
          onTap: () {
            // Navegar para a seção de desenho
          },
        ),
        _buildActivityCard(
          title: 'Recompensas',
          icon: Icons.star,
          color: AlphaColors.warning,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RewardsScreen()),
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildActivityCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRecentAchievements() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAchievement('Leitor Iniciante', Icons.menu_book, AlphaColors.primary),
          _buildAchievement('Matemático Curioso', Icons.calculate, AlphaColors.secondary),
          _buildAchievement('3 Dias Seguidos', Icons.local_fire_department, AlphaColors.warning),
          _buildAchievement('Explorador', Icons.explore, AlphaColors.tertiary),
        ],
      ),
    );
  }
  
  Widget _buildAchievement(String title, IconData icon, Color color) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AlphaColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Início', true, () {}),
          _buildNavItem(Icons.book, 'Histórias', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StoriesScreen()),
            );
          }),
          _buildNavItem(Icons.games, 'Jogos', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamesScreen()),
            );
          }),
          _buildNavItem(Icons.person, 'Perfil', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AlphaColors.primary : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AlphaColors.primary : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
} 