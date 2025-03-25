import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../widgets/learning_card.dart';
import '../widgets/character_avatar.dart';
import 'game_detail_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  
  final List<GameData> _gamesList = [
    GameData(
      id: 'game1',
      title: 'Caça ao Tesouro Matemático',
      description: 'Encontre os números que somam 10 e desbloqueie o baú do tesouro!',
      imagePath: 'assets/images/math_game.png',
      categoryName: 'Matemática',
      skills: ['Adição', 'Subtração'],
      recommendedAge: '6-8 anos',
      duration: '10 min',
      progress: 0.4,
      isLocked: false,
    ),
    GameData(
      id: 'game2',
      title: 'Soletrando',
      description: 'Aprenda a soletrar palavras novas de forma divertida!',
      imagePath: 'assets/images/spelling.png',
      categoryName: 'Português',
      skills: ['Vocabulário', 'Ortografia'],
      recommendedAge: '5-7 anos',
      duration: '5 min',
      progress: 0.3,
      isLocked: false,
    ),
    GameData(
      id: 'game3',
      title: 'Jogo da Memória',
      description: 'Encontre os pares de animais e aprenda sobre eles!',
      imagePath: 'assets/images/memory_game.png',
      categoryName: 'Ciências',
      skills: ['Memória', 'Classificação'],
      recommendedAge: '5-10 anos',
      duration: '8 min',
      progress: 0.0,
      isLocked: false,
    ),
    GameData(
      id: 'game4',
      title: 'Quebra-Cabeça Geográfico',
      description: 'Monte o mapa e descubra lugares incríveis ao redor do mundo!',
      imagePath: 'assets/images/geography_game.png',
      categoryName: 'Geografia',
      skills: ['Espacialidade', 'Geografia'],
      recommendedAge: '7-10 anos',
      duration: '15 min',
      progress: 0.0,
      isLocked: true,
    ),
    GameData(
      id: 'game5',
      title: 'Formas e Cores',
      description: 'Combine formas e cores para criar desenhos divertidos!',
      imagePath: 'assets/images/shapes_game.png',
      categoryName: 'Arte',
      skills: ['Criatividade', 'Reconhecimento de padrões'],
      recommendedAge: '5-7 anos',
      duration: '10 min',
      progress: 0.0,
      isLocked: false,
    ),
    GameData(
      id: 'game6',
      title: 'Música e Ritmo',
      description: 'Crie melodias e ritmos seguindo os padrões musicais!',
      imagePath: 'assets/images/music_game.png',
      categoryName: 'Música',
      skills: ['Ritmo', 'Coordenação'],
      recommendedAge: '6-9 anos',
      duration: '8 min',
      progress: 0.0,
      isLocked: true,
    ),
  ];
  
  final List<String> _categories = [
    'Todos',
    'Matemática',
    'Português',
    'Ciências',
    'Geografia',
    'Arte',
    'Música',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<GameData> _getFilteredGames(String category) {
    if (category == 'Todos') {
      return _gamesList;
    }
    return _gamesList.where((game) => game.categoryName == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlphaColors.background,
      appBar: AppBar(
        title: const Text('Jogos Educativos'),
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
      body: Column(
        children: [
          _buildFeaturedGame(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                final filteredGames = _getFilteredGames(category);
                return filteredGames.isEmpty
                    ? _buildEmptyCategory(category)
                    : _buildGameGrid(filteredGames);
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AlphaColors.secondary,
        child: const Icon(Icons.shuffle),
        onPressed: () {
          // Sugerir um jogo aleatório
          final availableGames = _gamesList.where((game) => !game.isLocked).toList();
          if (availableGames.isNotEmpty) {
            final randomIndex = DateTime.now().millisecondsSinceEpoch % availableGames.length;
            _openGameDetail(availableGames[randomIndex]);
          }
        },
      ),
    );
  }
  
  Widget _buildFeaturedGame() {
    // Escolhendo o primeiro jogo não bloqueado como destaque
    final featuredGame = _gamesList.firstWhere(
      (game) => !game.isLocked, 
      orElse: () => _gamesList[0],
    );
    
    return Container(
      margin: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getCategoryColor(featuredGame.categoryName).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Imagem de fundo
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              featuredGame.imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          // Overlay gradiente
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
          
          // Conteúdo
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () => _openGameDetail(featuredGame),
              splashColor: _getCategoryColor(featuredGame.categoryName).withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(featuredGame.categoryName),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            featuredGame.categoryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            featuredGame.recommendedAge,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      featuredGame.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      featuredGame.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Tag de destaque
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AlphaColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Destaque',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Botão de jogar
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.play_arrow,
                color: _getCategoryColor(featuredGame.categoryName),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGameGrid(List<GameData> games) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return _buildGameCard(game);
      },
    );
  }
  
  Widget _buildGameCard(GameData game) {
    return LearningCard(
      title: game.title,
      description: game.description,
      imagePath: game.imagePath,
      color: _getCategoryColor(game.categoryName),
      progress: game.progress,
      isLocked: game.isLocked,
      onTap: () => _openGameDetail(game),
    );
  }
  
  Widget _buildEmptyCategory(String category) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CharacterAvatar(
            size: 100,
            withBorder: true,
            withSpeechBubble: true,
            speechText: 'Novos jogos de $category em breve!',
          ),
          const SizedBox(height: 40),
          const Text(
            'Nenhum jogo disponível',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AlphaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Estamos preparando jogos de $category para você!',
            style: const TextStyle(
              color: AlphaColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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
  
  void _openGameDetail(GameData game) {
    if (game.isLocked) {
      _showLockedGameDialog();
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailScreen(game: game),
      ),
    );
  }
  
  void _showLockedGameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Jogo Bloqueado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock,
              size: 60,
              color: AlphaColors.secondary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Este jogo ainda está bloqueado!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete outros jogos e ganhe estrelas para desbloquear novos conteúdos.',
              style: TextStyle(
                fontSize: 14,
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
}

class GameData {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String categoryName;
  final List<String> skills;
  final String recommendedAge;
  final String duration;
  final double progress;
  final bool isLocked;
  
  const GameData({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.categoryName,
    required this.skills,
    required this.recommendedAge,
    required this.duration,
    required this.progress,
    required this.isLocked,
  });
} 