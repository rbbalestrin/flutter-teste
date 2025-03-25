import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../constants/theme.dart';
import '../widgets/reward_badge.dart';
import '../widgets/character_avatar.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ConfettiController _confettiController;
  
  // Dados simulados
  final int _totalStars = 120;
  final List<RewardData> _rewards = [
    RewardData(
      id: 'badge1',
      title: 'Leitor Iniciante',
      description: 'Leu 3 histórias',
      imagePath: 'assets/images/badge_reader.png',
      type: RewardType.badge,
      category: 'Histórias',
      isNew: true,
      isLocked: false,
    ),
    RewardData(
      id: 'badge2',
      title: 'Matemático Curioso',
      description: 'Completou 5 jogos de matemática',
      imagePath: 'assets/images/badge_math.png',
      type: RewardType.badge,
      category: 'Jogos',
      isNew: false,
      isLocked: false,
    ),
    RewardData(
      id: 'badge3',
      title: '3 Dias Seguidos',
      description: 'Usou o app por 3 dias seguidos',
      imagePath: 'assets/images/badge_streak.png',
      type: RewardType.badge,
      category: 'Conquistas',
      isNew: false,
      isLocked: false,
    ),
    RewardData(
      id: 'badge4',
      title: 'Explorador',
      description: 'Visitou todas as seções do app',
      imagePath: 'assets/images/badge_explorer.png',
      type: RewardType.badge,
      category: 'Conquistas',
      isNew: false,
      isLocked: false,
    ),
    RewardData(
      id: 'badge5',
      title: 'Criativo',
      description: 'Completou 3 atividades de desenho',
      imagePath: 'assets/images/badge_creative.png',
      type: RewardType.badge,
      category: 'Jogos',
      isNew: false,
      isLocked: true,
    ),
    RewardData(
      id: 'badge6',
      title: 'Super Leitor',
      description: 'Leu 10 histórias',
      imagePath: 'assets/images/badge_super_reader.png',
      type: RewardType.badge,
      category: 'Histórias',
      isNew: false,
      isLocked: true,
    ),
    RewardData(
      id: 'character1',
      title: 'Tito, o Coelho',
      description: 'Personagem desbloqueado',
      imagePath: 'assets/images/character1.png',
      type: RewardType.character,
      category: 'Personagens',
      isNew: false,
      isLocked: false,
    ),
    RewardData(
      id: 'character2',
      title: 'Lili, a Coruja',
      description: 'Personagem desbloqueado',
      imagePath: 'assets/images/character2.png',
      type: RewardType.character,
      category: 'Personagens',
      isNew: true,
      isLocked: false,
    ),
    RewardData(
      id: 'character3',
      title: 'Duda, a Esquilo',
      description: 'Personagem desbloqueado',
      imagePath: 'assets/images/character3.png',
      type: RewardType.character,
      category: 'Personagens',
      isNew: false,
      isLocked: false,
    ),
    RewardData(
      id: 'character4',
      title: 'Leo, o Leão',
      description: '200 estrelas para desbloquear',
      imagePath: 'assets/images/character4.png',
      type: RewardType.character,
      category: 'Personagens',
      isNew: false,
      isLocked: true,
    ),
  ];
  
  final List<String> _categories = [
    'Todos',
    'Conquistas',
    'Histórias',
    'Jogos',
    'Personagens',
  ];
  
  bool _isConfettiPlaying = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    
    // Verificar se há recompensas novas
    if (_rewards.any((reward) => reward.isNew)) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isConfettiPlaying = true;
        });
        _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _confettiController.dispose();
    super.dispose();
  }
  
  List<RewardData> _getFilteredRewards(String category) {
    if (category == 'Todos') {
      return _rewards;
    }
    return _rewards.where((reward) => reward.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlphaColors.background,
      appBar: AppBar(
        title: const Text('Minhas Recompensas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: _categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildStarsCounter(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _categories.map((category) {
                    final filteredRewards = _getFilteredRewards(category);
                    return _buildRewardsGrid(filteredRewards);
                  }).toList(),
                ),
              ),
            ],
          ),
          
          // Confete para novas recompensas
          if (_isConfettiPlaying)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.03,
                numberOfParticles: 20,
                gravity: 0.1,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
                onComplete: () {
                  setState(() {
                    _isConfettiPlaying = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildStarsCounter() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 32,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total de Estrelas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                '$_totalStars',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Próximo: 200',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRewardsGrid(List<RewardData> rewards) {
    if (rewards.isEmpty) {
      return _buildEmptyState();
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        return _buildRewardItem(reward);
      },
    );
  }
  
  Widget _buildRewardItem(RewardData reward) {
    if (reward.type == RewardType.badge) {
      return RewardBadge(
        title: reward.title,
        description: reward.description,
        imagePath: reward.imagePath,
        color: _getCategoryColor(reward.category),
        isNew: reward.isNew,
        isLocked: reward.isLocked,
        onTap: () {
          if (!reward.isLocked) {
            _showRewardDetails(reward);
          } else {
            _showLockedRewardDialog(reward);
          }
        },
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (!reward.isLocked) {
            _showRewardDetails(reward);
          } else {
            _showLockedRewardDialog(reward);
          }
        },
        child: Column(
          children: [
            CharacterAvatar(
              imagePath: reward.imagePath,
              size: 80,
              isSelected: reward.isNew,
              withBorder: true,
              borderColor: reward.isLocked ? Colors.grey : _getCategoryColor(reward.category),
              isInteractive: false,
            ),
            const SizedBox(height: 8),
            Text(
              reward.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: reward.isLocked ? Colors.grey : AlphaColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma recompensa aqui ainda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AlphaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Continue completando atividades para ganhar recompensas!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AlphaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showRewardDetails(RewardData reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (reward.type == RewardType.badge)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _getCategoryColor(reward.category).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: reward.imagePath != null
                    ? ClipOval(
                        child: Image.asset(
                          reward.imagePath!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.emoji_events,
                        size: 60,
                        color: _getCategoryColor(reward.category),
                      ),
              )
            else
              CharacterAvatar(
                imagePath: reward.imagePath,
                size: 120,
                withBorder: true,
                borderColor: _getCategoryColor(reward.category),
              ),
            const SizedBox(height: 16),
            Text(
              reward.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AlphaColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              reward.description,
              style: const TextStyle(
                fontSize: 16,
                color: AlphaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(reward.category).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                reward.category,
                style: TextStyle(
                  fontSize: 14,
                  color: _getCategoryColor(reward.category),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    reward.type == RewardType.badge
                        ? 'Conquista obtida em: 12/04/2023'
                        : 'Personagem desbloqueado em: 12/04/2023',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (reward.type == RewardType.badge) ...[
                    const SizedBox(height: 8),
                    Text(
                      '${(3 + _rewards.indexOf(reward) * 5)} de ${_rewards.length} conquistas',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          if (reward.isNew)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _getCategoryColor(reward.category),
              ),
              onPressed: () {
                // Marcar como visualizado
                setState(() {
                  final index = _rewards.indexOf(reward);
                  _rewards[index] = RewardData(
                    id: reward.id,
                    title: reward.title,
                    description: reward.description,
                    imagePath: reward.imagePath,
                    type: reward.type,
                    category: reward.category,
                    isNew: false,
                    isLocked: reward.isLocked,
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Legal!'),
            ),
        ],
      ),
    );
  }
  
  void _showLockedRewardDialog(RewardData reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recompensa Bloqueada'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock,
              size: 60,
              color: AlphaColors.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              reward.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              reward.description,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Complete mais atividades para desbloquear!',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Histórias':
        return AlphaColors.primary;
      case 'Jogos':
        return AlphaColors.secondary;
      case 'Conquistas':
        return AlphaColors.warning;
      case 'Personagens':
        return AlphaColors.tertiary;
      default:
        return AlphaColors.primary;
    }
  }
}

class RewardData {
  final String id;
  final String title;
  final String description;
  final String? imagePath;
  final RewardType type;
  final String category;
  final bool isNew;
  final bool isLocked;
  
  const RewardData({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath,
    required this.type,
    required this.category,
    required this.isNew,
    required this.isLocked,
  });
}

enum RewardType {
  badge,
  character,
}

// Constante para o confetti
const double pi = 3.1415926535897932; 