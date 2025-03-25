import 'package:flutter/material.dart';
import '../constants/theme.dart';
import 'dart:io';

class CharacterAvatar extends StatelessWidget {
  final String imagePath;
  final double size;
  final bool withBorder;
  final VoidCallback? onTap;
  final Color? borderColor;

  const CharacterAvatar({
    Key? key,
    required this.imagePath,
    this.size = 60,
    this.withBorder = false,
    this.onTap,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: withBorder
              ? Border.all(
                  color: borderColor ?? AlphaColors.primary,
                  width: 3,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Verifica se o arquivo existe (para imagens locais)
    if (imagePath.startsWith('assets/')) {
      // Para imagens de assets, usamos um placeholder durante o desenvolvimento
      return _buildPlaceholder();
    } else if (imagePath.startsWith('http')) {
      // Para imagens da web, use NetworkImage
      return Image.network(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
      );
    } else {
      // Para imagens locais (ex: câmera), use FileImage
      final file = File(imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );
      } else {
        return _buildErrorPlaceholder();
      }
    }
  }

  Widget _buildPlaceholder() {
    // Gera uma cor baseada no nome do arquivo
    final fileName = imagePath.split('/').last;
    final firstLetter = fileName.isNotEmpty ? fileName[0].toUpperCase() : '?';
    final colorValue = imagePath.hashCode & 0xFFFFFF;
    final color = Color(0xFF000000 | colorValue).withOpacity(0.8);
    
    return Container(
      color: color,
      width: size,
      height: size,
      child: Center(
        child: Text(
          firstLetter,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        size: size * 0.6,
        color: Colors.grey[500],
      ),
    );
  }
} 