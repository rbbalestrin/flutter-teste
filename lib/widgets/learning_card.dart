import 'package:flutter/material.dart';
import '../constants/theme.dart';

class LearningCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? imagePath;
  final IconData? icon;
  final Color color;
  final Color? borderColor;
  final VoidCallback onTap;
  final double progress;
  final bool isLocked;
  
  const LearningCard({
    Key? key,
    required this.title,
    this.description,
    this.imagePath,
    this.icon,
    this.color = AlphaColors.primary,
    this.borderColor,
    required this.onTap,
    this.progress = 0.0,
    this.isLocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: AlphaColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: borderColor != null 
            ? Border.all(color: borderColor!, width: 3) 
            : null,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Conteúdo principal
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ícone ou imagem
                    if (imagePath != null)
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(imagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else if (icon != null)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: color, size: 30),
                      ),
                    
                    const SizedBox(height: 16),
                    
                    // Título
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AlphaColors.textPrimary,
                      ),
                    ),
                    
                    // Descrição
                    if (description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AlphaColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    // Barra de progresso
                    if (progress > 0) ...[
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(progress * 100).toInt()}% concluído',
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Overlay se estiver bloqueado
              if (isLocked)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.lock_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                
              // Faixa colorida no topo
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 