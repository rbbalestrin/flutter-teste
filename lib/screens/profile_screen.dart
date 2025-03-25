import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/theme.dart';
import '../widgets/character_avatar.dart';
import '../widgets/alpha_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dados simulados do usuário
  String userName = "Miguel";
  int userAge = 7;
  String userAvatarPath = "assets/images/avatars/boy1.png";
  int userLevel = 3;
  int totalStars = 128;
  int completedActivities = 24;
  int streakDays = 5;
  
  // Configurações
  bool musicOn = true;
  bool soundEffectsOn = true;
  bool readAloudOn = true;
  bool notificationsOn = true;
  bool parentalControlsOn = false;
  
  // Lista simulada de conquistas recentes
  final List<Map<String, dynamic>> recentAchievements = [
    {
      'icon': Icons.star,
      'title': 'Estrela da Matemática',
      'description': 'Completou 10 lições de matemática',
      'color': Colors.amber,
    },
    {
      'icon': Icons.menu_book,
      'title': 'Leitor Ávido',
      'description': 'Leu 5 histórias completas',
      'color': Colors.blue,
    },
    {
      'icon': Icons.science,
      'title': 'Cientista Curioso',
      'description': 'Explorou todos os experimentos',
      'color': Colors.green,
    },
    {
      'icon': Icons.emoji_events,
      'title': 'Campeão de Vocabulário',
      'description': 'Aprendeu 50 palavras novas',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlphaColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsSection(),
                  const SizedBox(height: 24),
                  _buildAchievementsSection(),
                  const SizedBox(height: 24),
                  _buildSettingsSection(),
                  const SizedBox(height: 24),
                  _buildParentalSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160,
      floating: false,
      pinned: true,
      backgroundColor: AlphaColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: AlphaColors.primaryGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
            child: Row(
              children: [
                CharacterAvatar(
                  imagePath: userAvatarPath,
                  size: 80,
                  withBorder: true,
                  borderColor: Colors.white,
                  onTap: _showAvatarSelectionDialog,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "$userAge anos",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: _showEditProfileDialog,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Nível $userLevel",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Retornar para a tela anterior
        },
      ),
    );
  }

  Widget _buildStatsSection() {
    return Card(
      elevation: a8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Suas estatísticas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AlphaColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  Icons.star,
                  "$totalStars",
                  "Estrelas",
                  Colors.amber,
                ),
                _buildStatItem(
                  Icons.task_alt,
                  "$completedActivities",
                  "Atividades",
                  AlphaColors.tertiary,
                ),
                _buildStatItem(
                  Icons.local_fire_department,
                  "$streakDays",
                  "Dias seguidos",
                  AlphaColors.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AlphaColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AlphaColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Card(
      elevation: a8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Conquistas recentes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AlphaColors.textPrimary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Navegar para a tela completa de conquistas
                  },
                  child: const Text("Ver todas"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentAchievements.length,
                itemBuilder: (context, index) {
                  final achievement = recentAchievements[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: achievement['color'].withOpacity(0.1),
                      border: Border.all(
                        color: achievement['color'].withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          achievement['icon'],
                          color: achievement['color'],
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            achievement['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AlphaColors.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Card(
      elevation: a8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Configurações",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AlphaColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingToggle(
              "Música",
              Icons.music_note,
              musicOn,
              (value) => setState(() => musicOn = value),
            ),
            _buildSettingToggle(
              "Efeitos sonoros",
              Icons.volume_up,
              soundEffectsOn,
              (value) => setState(() => soundEffectsOn = value),
            ),
            _buildSettingToggle(
              "Leitura em voz alta",
              Icons.record_voice_over,
              readAloudOn,
              (value) => setState(() => readAloudOn = value),
            ),
            _buildSettingToggle(
              "Notificações",
              Icons.notifications,
              notificationsOn,
              (value) => setState(() => notificationsOn = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingToggle(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: AlphaColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AlphaColors.textPrimary,
            ),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            activeColor: AlphaColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildParentalSection() {
    return Card(
      elevation: a8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.lock,
                  color: AlphaColors.textPrimary,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "Área dos pais",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AlphaColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingToggle(
              "Controle dos pais",
              Icons.family_restroom,
              parentalControlsOn,
              (value) {
                if (value) {
                  _showParentalPinDialog();
                } else {
                  setState(() => parentalControlsOn = false);
                }
              },
            ),
            const SizedBox(height: 8),
            AlphaButton(
              label: "Configurações dos pais",
              icon: Icons.settings,
              isOutlined: true,
              onPressed: _showParentalPinDialog,
            ),
          ],
        ),
      ),
    );
  }

  void _showAvatarSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Escolha seu avatar"),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              final imagePath = "assets/images/avatars/avatar_${index + 1}.png";
              return GestureDetector(
                onTap: () {
                  setState(() {
                    userAvatarPath = imagePath;
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AlphaColors.primary.withOpacity(0.2),
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 40,
                          color: AlphaColors.primary,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: userName);
    final ageController = TextEditingController(text: userAge.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar Perfil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: "Idade",
                prefixIcon: Icon(Icons.cake),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userAge = int.tryParse(ageController.text) ?? userAge;
              });
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _showParentalPinDialog() {
    final pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Área dos Pais"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Digite o PIN de acesso para as configurações dos pais",
              style: TextStyle(color: AlphaColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              decoration: const InputDecoration(
                labelText: "PIN",
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              // Verificar PIN (1234 como exemplo)
              if (pinController.text == "1234") {
                setState(() {
                  parentalControlsOn = true;
                });
                Navigator.pop(context);
                // Aqui navegaria para a área de configurações dos pais
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("PIN incorreto. Tente novamente."),
                    backgroundColor: AlphaColors.error,
                  ),
                );
              }
            },
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
  }
} 