import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../constants/theme.dart';

class RewardBadge extends StatefulWidget {
  final String title;
  final String? imagePath;
  final IconData? icon;
  final Color color;
  final bool isNew;
  final bool isLocked;
  final VoidCallback? onTap;
  final String? description;
  
  const RewardBadge({
    Key? key,
    required this.title,
    this.imagePath,
    this.icon,
    this.color = AlphaColors.primary,
    this.isNew = false,
    this.isLocked = false,
    this.onTap,
    this.description,
  }) : super(key: key);

  @override
  State<RewardBadge> createState() => _RewardBadgeState();
}

class _RewardBadgeState extends State<RewardBadge> {
  late ConfettiController _confettiController;
  
  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    
    if (widget.isNew && !widget.isLocked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _confettiController.play();
      });
    }
  }
  
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Badge container
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              color: widget.isLocked 
                ? Colors.grey.shade300 
                : AlphaColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: (widget.isLocked 
                    ? Colors.grey 
                    : widget.color).withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícone ou imagem da recompensa
                _buildBadgeIcon(),
                
                const SizedBox(height: 10),
                
                // Título da recompensa
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: widget.isLocked 
                        ? Colors.grey.shade600 
                        : AlphaColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                // Descrição se existir
                if (widget.description != null && !widget.isLocked) ...[
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      widget.description!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AlphaColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Indicador de novo
          if (widget.isNew && !widget.isLocked)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AlphaColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'Novo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
          // Efeito de confete
          if (widget.isNew && !widget.isLocked)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.1,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.purple,
                  Colors.orange,
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildBadgeIcon() {
    // Se estiver bloqueado, mostra um ícone de cadeado
    if (widget.isLocked) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.lock_outline,
          color: Colors.white,
          size: 24,
        ),
      );
    }
    
    // Se tiver imagem, mostra a imagem
    if (widget.imagePath != null) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color,
            width: 3,
          ),
          image: DecorationImage(
            image: AssetImage(widget.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    
    // Caso contrário, mostra o ícone
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.color,
          width: 3,
        ),
      ),
      child: Icon(
        widget.icon ?? Icons.star,
        color: widget.color,
        size: 30,
      ),
    );
  }
} 