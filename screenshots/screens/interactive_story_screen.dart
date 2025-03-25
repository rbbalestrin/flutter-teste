import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';
import '../constants/theme.dart';
import '../widgets/alpha_button.dart';
import '../widgets/character_avatar.dart';
import 'stories_screen.dart';
import 'rewards_screen.dart';

class InteractiveStoryScreen extends StatefulWidget {
  final StoryData story;
  
  const InteractiveStoryScreen({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  State<InteractiveStoryScreen> createState() => _InteractiveStoryScreenState();
}

class _InteractiveStoryScreenState extends State<InteractiveStoryScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _backgroundAnimation;
  
  int _currentPage = 0;
  final int _totalPages = 5; // Simulando 5 páginas para esta história
  bool _showDecisions = false;
  bool _isComplete = false;
  
  // Simulação de páginas da história
  final List<StoryPageData> _storyPages = [];
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    // Gerando páginas simuladas para a história
    _generateStoryPages();
    
    // Verificar se deve mostrar decisões após um tempo
    _checkDecisions();
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  void _generateStoryPages() {
    // Exemplo de páginas simuladas
    _storyPages.add(
      StoryPageData(
        text: 'Era uma vez um coelhinho chamado Tito que vivia na floresta encantada. '
            'Certo dia, ele percebeu que estava perdido e não conseguia encontrar o caminho de volta para casa.',
        imagePath: 'assets/images/story_page1.png',
        characterPath: 'assets/images/character1.png',
        characterName: 'Tito',
        hasInteraction: false,
        decisions: [],
        backgroundAnimation: 'assets/animations/forest_bg.json',
      ),
    );
    
    _storyPages.add(
      StoryPageData(
        text: 'Enquanto caminhava preocupado, Tito encontrou a coruja Lili, '
            'conhecida por ser a mais sábia de toda a floresta. "Você parece perdido", disse Lili. '
            '"Posso te ajudar a encontrar o caminho de volta."',
        imagePath: 'assets/images/story_page2.png',
        characterPath: 'assets/images/character2.png',
        characterName: 'Lili',
        hasInteraction: true,
        decisions: [],
        backgroundAnimation: 'assets/animations/forest_bg.json',
      ),
    );
    
    _storyPages.add(
      StoryPageData(
        text: 'Lili explicou que havia dois caminhos que Tito poderia seguir: '
            'o caminho da montanha, que era mais curto mas perigoso, ou o caminho do rio, '
            'que era mais longo mas seguro.',
        imagePath: 'assets/images/story_page3.png',
        characterPath: 'assets/images/character2.png',
        characterName: 'Lili',
        hasInteraction: false,
        decisions: [
          DecisionOptionData(
            text: 'Escolher o caminho da montanha',
            nextPageIndex: 3,
            imagePath: 'assets/images/mountain_path.png',
          ),
          DecisionOptionData(
            text: 'Escolher o caminho do rio',
            nextPageIndex: 4,
            imagePath: 'assets/images/river_path.png',
          ),
        ],
        backgroundAnimation: 'assets/animations/forest_bg.json',
      ),
    );
    
    _storyPages.add(
      StoryPageData(
        text: 'Tito escolheu o caminho da montanha. Foi uma subida difícil, '
            'mas ele encontrou Duda, a esquilo, que conhecia um atalho secreto. '
            'Juntos, eles chegaram rapidamente à casa de Tito.',
        imagePath: 'assets/images/story_page4.png',
        characterPath: 'assets/images/character3.png',
        characterName: 'Duda',
        hasInteraction: true,
        decisions: [],
        backgroundAnimation: 'assets/animations/mountain_bg.json',
      ),
    );
    
    _storyPages.add(
      StoryPageData(
        text: 'Tito escolheu o caminho do rio. Durante a jornada, ele conheceu muitos animais '
            'e aprendeu sobre a importância da água para a floresta. Embora tenha demorado mais, '
            'Tito fez novos amigos e chegou seguro em casa.',
        imagePath: 'assets/images/story_page5.png',
        characterPath: 'assets/images/character1.png',
        characterName: 'Tito',
        hasInteraction: true,
        decisions: [],
        backgroundAnimation: 'assets/animations/river_bg.json',
      ),
    );
  }
  
  void _checkDecisions() {
    if (_currentPage < _storyPages.length && _storyPages[_currentPage].decisions.isNotEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showDecisions = true;
          });
        }
      });
    } else {
      setState(() {
        _showDecisions = false;
      });
    }
  }
  
  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _completeStory();
    }
  }
  
  void _makeDecision(int nextPageIndex) {
    setState(() {
      _showDecisions = false;
    });
    
    _pageController.animateToPage(
      nextPageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _showDecisions = false;
    });
    
    _animationController.reset();
    _animationController.forward();
    
    // Verificar se há decisões na nova página depois de um atraso
    Future.delayed(const Duration(seconds: 1), () {
      _checkDecisions();
    });
  }
  
  void _completeStory() {
    setState(() {
      _isComplete = true;
    });
    _confettiController.play();
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isComplete) {
      return _buildCompletionScreen();
    }
    
    return Scaffold(
      body: Stack(
        children: [
          // Fundo animado
          if (_currentPage < _storyPages.length)
            Positioned.fill(
              child: FadeTransition(
                opacity: _backgroundAnimation,
                child: Lottie.asset(
                  _storyPages[_currentPage].backgroundAnimation,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          
          // Conteúdo da página
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    physics: _showDecisions 
                        ? const NeverScrollableScrollPhysics() 
                        : const BouncingScrollPhysics(),
                    itemCount: _storyPages.length,
                    itemBuilder: (context, index) {
                      return _buildStoryPage(_storyPages[index]);
                    },
                  ),
                ),
                if (!_showDecisions) _buildNavigationBar(),
              ],
            ),
          ),
          
          // Sobreposição de decisões
          if (_showDecisions && _currentPage < _storyPages.length)
            _buildDecisionsOverlay(_storyPages[_currentPage].decisions),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white),
            ),
            onPressed: () {
              // Mostrar diálogo de confirmação antes de sair
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sair da história?'),
                  content: const Text('Seu progresso será salvo para continuar depois.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Fecha o diálogo
                        Navigator.pop(context); // Volta para a tela anterior
                      },
                      child: const Text('Sair'),
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(),
          // Indicador de progresso
          Row(
            children: List.generate(
              _totalPages,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index <= _currentPage 
                      ? AlphaColors.primary 
                      : Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.volume_up, color: Colors.white),
            ),
            onPressed: () {
              // Alternar áudio narração
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildStoryPage(StoryPageData page) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem da cena
          if (page.imagePath != null)
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(page.imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
          // Personagem falando
          if (page.characterPath != null)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: CharacterAvatar(
                imagePath: page.characterPath,
                name: page.characterName,
                size: 70,
                withSpeechBubble: true,
                speechText: page.text,
              ),
            )
          else
            // Texto da narrativa
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                page.text,
                style: const TextStyle(
                  fontSize: 18,
                  color: AlphaColors.textPrimary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          
          // Elemento interativo (se houver)
          if (page.hasInteraction)
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  // Mostrar animação ou efeito de interação
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AlphaColors.secondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AlphaColors.secondary,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: AlphaColors.secondary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Toque para interagir',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AlphaColors.secondary,
                        ),
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
  
  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão voltar
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: AlphaColors.primary),
            ),
            onPressed: _currentPage > 0
                ? () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
          ),
          
          // Botão próximo
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: AlphaColors.primary),
            ),
            onPressed: _storyPages[_currentPage].decisions.isEmpty
                ? _nextPage
                : null,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDecisionsOverlay(List<DecisionOptionData> decisions) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'O que Tito deve fazer?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AlphaColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Opções de decisão
              ...decisions.map((decision) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildDecisionOption(decision),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDecisionOption(DecisionOptionData decision) {
    return GestureDetector(
      onTap: () => _makeDecision(decision.nextPageIndex),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AlphaColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AlphaColors.primary,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            if (decision.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  decision.imagePath!,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                decision.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AlphaColors.primary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AlphaColors.primary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCompletionScreen() {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com confetes
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 1,
              emissionFrequency: 0.05,
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
            ),
          ),
          
          // Conteúdo
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AlphaColors.success.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AlphaColors.success,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'História Concluída!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AlphaColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Você ganhou 50 estrelas e desbloqueou uma nova recompensa!',
                    style: TextStyle(
                      fontSize: 18,
                      color: AlphaColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AlphaColors.warning.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AlphaColors.warning,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '+50',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AlphaColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AlphaColors.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: AlphaColors.secondary,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Novo Emblema',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AlphaColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AlphaButton(
                        label: 'Voltar às Histórias',
                        icon: Icons.menu_book,
                        color: AlphaColors.primary,
                        onPressed: () {
                          // Voltar para lista de histórias
                          Navigator.pop(context);
                        },
                      ),
                      AlphaButton(
                        label: 'Ver Recompensas',
                        icon: Icons.star,
                        color: AlphaColors.warning,
                        onPressed: () {
                          // Ir para tela de recompensas
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RewardsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoryPageData {
  final String text;
  final String? imagePath;
  final String? characterPath;
  final String? characterName;
  final bool hasInteraction;
  final List<DecisionOptionData> decisions;
  final String backgroundAnimation;
  
  const StoryPageData({
    required this.text,
    this.imagePath,
    this.characterPath,
    this.characterName,
    required this.hasInteraction,
    required this.decisions,
    required this.backgroundAnimation,
  });
}

class DecisionOptionData {
  final String text;
  final int nextPageIndex;
  final String? imagePath;
  
  const DecisionOptionData({
    required this.text,
    required this.nextPageIndex,
    this.imagePath,
  });
}

// Constante para o confetti
const double pi = 3.1415926535897932; 