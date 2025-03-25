class InteractiveStory {
  final String id;
  final String title;
  final String description;
  final String thumbnailPath;
  final String? backgroundMusicPath;
  final List<String> tags;
  final List<StoryPage> pages;
  final int recommendedAge;
  final StoryTheme theme;
  final int pointsToEarn;
  
  const InteractiveStory({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailPath,
    this.backgroundMusicPath,
    required this.tags,
    required this.pages,
    required this.recommendedAge,
    required this.theme,
    required this.pointsToEarn,
  });
  
  // Duração estimada da história com base na quantidade de texto
  Duration get estimatedDuration {
    int totalTextLength = 0;
    for (var page in pages) {
      totalTextLength += page.text.length;
    }
    
    // Estimativa: 5 caracteres por segundo para crianças
    return Duration(seconds: totalTextLength ~/ 5);
  }
  
  // Verificar se a história está disponível para a idade do usuário
  bool isAppropriateFor(int userAge) {
    // Exibir histórias recomendadas para a idade do usuário ou até 2 anos abaixo
    return userAge >= recommendedAge - 2;
  }
}

class StoryPage {
  final String id;
  final String text;
  final String? imagePath;
  final String? soundEffectPath;
  final String? narrationPath;
  final List<InteractionElement>? interactions;
  final List<DecisionOption>? decisions;
  final bool hasAnimation;
  final List<VocabularyWord>? vocabularyWords;
  
  const StoryPage({
    required this.id,
    required this.text,
    this.imagePath,
    this.soundEffectPath,
    this.narrationPath,
    this.interactions,
    this.decisions,
    this.hasAnimation = false,
    this.vocabularyWords,
  });
  
  // Verificar se é uma página de decisão
  bool get isDecisionPage => decisions != null && decisions!.isNotEmpty;
  
  // Verificar se possui elementos de interação
  bool get isInteractive => interactions != null && interactions!.isNotEmpty;
  
  // Verificar se é a página final
  bool get isFinalPage => !isDecisionPage;
}

class DecisionOption {
  final String id;
  final String text;
  final String nextPageId;
  final String? imagePath;
  
  const DecisionOption({
    required this.id,
    required this.text,
    required this.nextPageId,
    this.imagePath,
  });
}

class InteractionElement {
  final String id;
  final InteractionType type;
  final Rect position;
  final String? imagePath;
  final String? soundPath;
  final String? targetText;
  final String? feedbackText;
  
  const InteractionElement({
    required this.id,
    required this.type,
    required this.position,
    this.imagePath,
    this.soundPath,
    this.targetText,
    this.feedbackText,
  });
}

class VocabularyWord {
  final String word;
  final String definition;
  final String? imagePath;
  final String? pronunciationPath;
  
  const VocabularyWord({
    required this.word,
    required this.definition,
    this.imagePath,
    this.pronunciationPath,
  });
}

enum InteractionType {
  tap,
  drag,
  shake,
  color,
  trace,
}

enum StoryTheme {
  adventure,
  science,
  nature,
  fantasy,
  space,
  animals,
  history,
  mythology,
}

class Rect {
  final double x;
  final double y;
  final double width;
  final double height;
  
  const Rect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
} 