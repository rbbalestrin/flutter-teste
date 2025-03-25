import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../widgets/alpha_button.dart';
import '../widgets/learning_card.dart';
import 'story_detail_screen.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final List<String> _categories = [
    'Todas',
    'Aventura',
    'Animais',
    'Ciências',
    'Espaço',
    'Natureza',
    'Amizade',
  ];
  
  String _selectedCategory = 'Todas';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  
  final List<StoryData> _storiesList = [
    StoryData(
      id: 'story1',
      title: 'A Floresta Encantada',
      description: 'Ajude o coelho Tito a encontrar o caminho para casa através da floresta mágica.',
      imagePath: 'assets/images/forest_story.png',
      categoryName: 'Aventura',
      recommendedAge: '5-7 anos',
      duration: '10 min',
      isCompleted: false,
      progress: 0.6,
    ),
    StoryData(
      id: 'story2',
      title: 'O Mistério do Oceano',
      description: 'Descubra junto com a baleia Lia os segredos escondidos nas profundezas do mar.',
      imagePath: 'assets/images/ocean_story.png',
      categoryName: 'Animais',
      recommendedAge: '6-8 anos',
      duration: '15 min',
      isCompleted: false,
      progress: 0.0,
    ),
    StoryData(
      id: 'story3',
      title: 'Aventuras no Espaço',
      description: 'Viaje com o astronauta Léo para conhecer planetas e estrelas do nosso universo.',
      imagePath: 'assets/images/space_story.png',
      categoryName: 'Espaço',
      recommendedAge: '7-10 anos',
      duration: '20 min',
      isCompleted: false,
      progress: 0.0,
    ),
    StoryData(
      id: 'story4',
      title: 'Os Cientistas Curiosos',
      description: 'Acompanhe Ana e Pedro em experimentos científicos divertidos e educativos.',
      imagePath: 'assets/images/science_story.png',
      categoryName: 'Ciências',
      recommendedAge: '6-9 anos',
      duration: '12 min',
      isCompleted: true,
      progress: 1.0,
    ),
    StoryData(
      id: 'story5',
      title: 'O Mundo das Plantas',
      description: 'Descubra como as árvores, flores e plantas são importantes para nosso planeta.',
      imagePath: 'assets/images/plants_story.png',
      categoryName: 'Natureza',
      recommendedAge: '5-8 anos',
      duration: '10 min',
      isCompleted: false,
      progress: 0.3,
    ),
    StoryData(
      id: 'story6',
      title: 'Amigos Inseparáveis',
      description: 'Uma história sobre amizade, companheirismo e como ajudar uns aos outros.',
      imagePath: 'assets/images/friends_story.png',
      categoryName: 'Amizade',
      recommendedAge: '5-7 anos',
      duration: '8 min',
      isCompleted: false,
      progress: 0.0,
    ),
  ];
  
  List<StoryData> get _filteredStories {
    if (_selectedCategory == 'Todas') {
      return _storiesList;
    }
    
    return _storiesList.where((story) => 
      story.categoryName == _selectedCategory).toList();
  }
  
  List<StoryData> get _searchResults {
    if (_searchController.text.isEmpty) {
      return _filteredStories;
    }
    
    final query = _searchController.text.toLowerCase();
    return _filteredStories.where((story) => 
      story.title.toLowerCase().contains(query) || 
      story.description.toLowerCase().contains(query)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlphaColors.background,
      appBar: AppBar(
        title: _isSearching
          ? TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar histórias...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              onChanged: (value) {
                setState(() {});
              },
            )
          : const Text('Histórias Interativas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categorias horizontais
          _buildCategoriesBar(),
          
          // Destaque/banner para histórias recomendadas
          _buildFeaturedStoryBanner(),
          
          // Lista de histórias
          Expanded(
            child: _searchResults.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return _buildStoryCard(_searchResults[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoriesBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AlphaColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : AlphaColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildFeaturedStoryBanner() {
    // Escolhendo a primeira história para destaque
    final featuredStory = _storiesList[0];
    
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(featuredStory.imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AlphaColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _openStoryDetail(featuredStory),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AlphaColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Destaque da Semana',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  featuredStory.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  featuredStory.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStoryCard(StoryData story) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: LearningCard(
        title: story.title,
        description: story.description,
        imagePath: story.imagePath,
        color: _getCategoryColor(story.categoryName),
        progress: story.progress,
        onTap: () => _openStoryDetail(story),
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
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
  
  void _openStoryDetail(StoryData story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryDetailScreen(story: story),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma história encontrada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AlphaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tente buscar com outras palavras',
            style: TextStyle(
              color: AlphaColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          AlphaButton(
            label: 'Ver todas as histórias',
            icon: Icons.refresh,
            onPressed: () {
              setState(() {
                _selectedCategory = 'Todas';
                _searchController.clear();
                _isSearching = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

class StoryData {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String categoryName;
  final String recommendedAge;
  final String duration;
  final bool isCompleted;
  final double progress;
  
  const StoryData({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.categoryName,
    required this.recommendedAge,
    required this.duration,
    required this.isCompleted,
    required this.progress,
  });
} 