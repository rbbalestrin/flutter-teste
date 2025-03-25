class StudentProgress {
  final String id;
  final String name;
  final int age;
  final String? avatarPath;
  final int totalPoints;
  final int level;
  final List<ModuleProgress> modules;
  final List<String> unlockedBadges;
  final List<String> unlockedCharacters;
  final int streakDays;
  final DateTime lastLoginDate;
  
  const StudentProgress({
    required this.id,
    required this.name,
    required this.age,
    this.avatarPath,
    required this.totalPoints,
    required this.level,
    required this.modules,
    required this.unlockedBadges,
    required this.unlockedCharacters,
    required this.streakDays,
    required this.lastLoginDate,
  });
  
  // Obter XP necessário para o próximo nível
  int get xpForNextLevel => 100 * (level + 1);
  
  // Calcular progresso geral com base nos módulos
  double get overallProgress {
    if (modules.isEmpty) return 0.0;
    
    double totalCompleted = 0.0;
    for (final module in modules) {
      totalCompleted += module.percentComplete;
    }
    
    return totalCompleted / modules.length;
  }
  
  // Verificar se o usuário pode desbloquear um novo módulo
  bool canUnlockNextModule(String currentModuleId) {
    final currentModuleIndex = modules.indexWhere((module) => module.id == currentModuleId);
    if (currentModuleIndex == -1 || currentModuleIndex >= modules.length - 1) return false;
    
    return modules[currentModuleIndex].percentComplete >= 0.7; // 70% completo
  }
  
  // Adicionar pontos ao aluno
  StudentProgress addPoints(int points) {
    int newTotalPoints = totalPoints + points;
    int newLevel = level;
    
    // Verificar se subiu de nível
    while (newTotalPoints >= xpForNextLevel) {
      newTotalPoints -= xpForNextLevel;
      newLevel++;
    }
    
    return StudentProgress(
      id: id,
      name: name,
      age: age,
      avatarPath: avatarPath,
      totalPoints: newTotalPoints,
      level: newLevel,
      modules: modules,
      unlockedBadges: unlockedBadges,
      unlockedCharacters: unlockedCharacters,
      streakDays: streakDays,
      lastLoginDate: lastLoginDate,
    );
  }
  
  // Atualizar progresso de um módulo específico
  StudentProgress updateModuleProgress(String moduleId, double newProgress) {
    final updatedModules = modules.map((module) {
      if (module.id == moduleId) {
        return module.copyWith(percentComplete: newProgress);
      }
      return module;
    }).toList();
    
    return StudentProgress(
      id: id,
      name: name,
      age: age,
      avatarPath: avatarPath,
      totalPoints: totalPoints,
      level: level,
      modules: updatedModules,
      unlockedBadges: unlockedBadges,
      unlockedCharacters: unlockedCharacters,
      streakDays: streakDays,
      lastLoginDate: lastLoginDate,
    );
  }
  
  // Adicionar uma nova conquista/insígnia
  StudentProgress addBadge(String badgeId) {
    if (unlockedBadges.contains(badgeId)) return this;
    
    return StudentProgress(
      id: id,
      name: name,
      age: age,
      avatarPath: avatarPath,
      totalPoints: totalPoints,
      level: level,
      modules: modules,
      unlockedBadges: [...unlockedBadges, badgeId],
      unlockedCharacters: unlockedCharacters,
      streakDays: streakDays,
      lastLoginDate: lastLoginDate,
    );
  }
  
  // Desbloquear um novo personagem
  StudentProgress unlockCharacter(String characterId) {
    if (unlockedCharacters.contains(characterId)) return this;
    
    return StudentProgress(
      id: id,
      name: name,
      age: age,
      avatarPath: avatarPath,
      totalPoints: totalPoints,
      level: level,
      modules: modules,
      unlockedBadges: unlockedBadges,
      unlockedCharacters: [...unlockedCharacters, characterId],
      streakDays: streakDays,
      lastLoginDate: lastLoginDate,
    );
  }
  
  // Atualizar login diário e streak
  StudentProgress updateLoginStreak(DateTime today) {
    final difference = today.difference(lastLoginDate).inDays;
    int newStreakDays = streakDays;
    
    // Se logou no dia seguinte, aumenta o streak
    if (difference == 1) {
      newStreakDays++;
    } 
    // Se ficou mais de um dia sem logar, perde o streak
    else if (difference > 1) {
      newStreakDays = 1;
    }
    // Se for o mesmo dia, mantém o streak
    
    return StudentProgress(
      id: id,
      name: name,
      age: age,
      avatarPath: avatarPath,
      totalPoints: totalPoints,
      level: level,
      modules: modules,
      unlockedBadges: unlockedBadges,
      unlockedCharacters: unlockedCharacters,
      streakDays: newStreakDays,
      lastLoginDate: today,
    );
  }
  
  // Criar um objeto vazio para novos usuários
  factory StudentProgress.empty(String id, String name, int age) {
    return StudentProgress(
      id: id,
      name: name,
      age: age,
      avatarPath: null,
      totalPoints: 0,
      level: 1,
      modules: [],
      unlockedBadges: [],
      unlockedCharacters: [],
      streakDays: 0,
      lastLoginDate: DateTime.now(),
    );
  }
}

class ModuleProgress {
  final String id;
  final String name;
  final double percentComplete;
  final List<ActivityProgress> activities;
  final DateTime? lastAccessedDate;
  
  const ModuleProgress({
    required this.id,
    required this.name,
    required this.percentComplete,
    required this.activities,
    this.lastAccessedDate,
  });
  
  // Método para atualizar o módulo
  ModuleProgress copyWith({
    String? id,
    String? name,
    double? percentComplete,
    List<ActivityProgress>? activities,
    DateTime? lastAccessedDate,
  }) {
    return ModuleProgress(
      id: id ?? this.id,
      name: name ?? this.name,
      percentComplete: percentComplete ?? this.percentComplete,
      activities: activities ?? this.activities,
      lastAccessedDate: lastAccessedDate ?? this.lastAccessedDate,
    );
  }
}

class ActivityProgress {
  final String id;
  final String name;
  final ActivityType type;
  final bool isCompleted;
  final int scoreEarned;
  final int maxScore;
  final DateTime? completedDate;
  
  const ActivityProgress({
    required this.id,
    required this.name,
    required this.type,
    required this.isCompleted,
    required this.scoreEarned,
    required this.maxScore,
    this.completedDate,
  });
  
  // Porcentagem de acertos para esta atividade
  double get percentCorrect {
    if (maxScore == 0) return 0.0;
    return scoreEarned / maxScore;
  }
  
  // Marcar como completa
  ActivityProgress markAsCompleted(int newScore) {
    return ActivityProgress(
      id: id,
      name: name,
      type: type,
      isCompleted: true,
      scoreEarned: newScore,
      maxScore: maxScore,
      completedDate: DateTime.now(),
    );
  }
}

enum ActivityType {
  quiz,
  game,
  story,
  puzzle,
  drawing,
  matching,
} 