import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/theme.dart';
import '../widgets/alpha_button.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;
  bool _isLastPage = false;
  
  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Bem-vindo ao Alpha Learn!',
      description: 'Embarque em uma jornada divertida de aprendizado com seus novos amigos!',
      animationPath: 'assets/animations/welcome.json',
      backgroundColor: AlphaColors.primary,
    ),
    OnboardingData(
      title: 'Histórias Interativas',
      description: 'Leia histórias divertidas, tome decisões e aprenda com os personagens!',
      animationPath: 'assets/animations/reading.json',
      backgroundColor: AlphaColors.secondary,
    ),
    OnboardingData(
      title: 'Jogos e Desafios',
      description: 'Complete desafios e ganhe prêmios enquanto aprende novas habilidades!',
      animationPath: 'assets/animations/playing.json',
      backgroundColor: AlphaColors.tertiary,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _isLastPage = page == _totalPages - 1;
    });
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _totalPages - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_isLastPage) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _finishOnboarding() {
    // Em um app real, definir flag para não mostrar novamente o onboarding
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView para deslisar entre as páginas
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _totalPages,
            itemBuilder: (context, index) {
              final data = _onboardingData[index];
              return OnboardingPage(data: data);
            },
          ),
          
          // Indicadores de página na parte inferior
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _totalPages,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentPage == index ? 30 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          
          // Botões na parte inferior
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão de pular (apenas nas primeiras páginas)
                if (!_isLastPage)
                  TextButton(
                    onPressed: _skipToEnd,
                    child: const Text(
                      'Pular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 80),
                  
                // Botão de próximo/começar
                AlphaButton(
                  label: _isLastPage ? 'Começar' : 'Próximo',
                  icon: _isLastPage ? Icons.rocket_launch : Icons.arrow_forward,
                  color: _isLastPage ? AlphaColors.success : Colors.white,
                  onPressed: _nextPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  
  const OnboardingPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: data.backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Lottie.asset(
                data.animationPath,
                repeat: true,
                animate: true,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              data.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String animationPath;
  final Color backgroundColor;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.animationPath,
    required this.backgroundColor,
  });
} 