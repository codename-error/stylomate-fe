import 'package:flutter/material.dart';
import 'dart:convert';

Widget base64Builder(String base64String) {
    try {
      if (base64String.isEmpty) {
        return const Icon(Icons.broken_image, size: 50);
      }
      final RegExp regex = RegExp(r'data:image/[^;]+;base64,');
      final String cleanedBase64 = base64String.replaceFirst(regex, '');
      
      return Image.memory(
        base64Decode(cleanedBase64),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading image: $error');
          return const Icon(Icons.broken_image, size: 50);
        },
      );
    } catch (e) {
      debugPrint('Failed to decode base64 image: $e');
      return const Icon(Icons.broken_image, size: 50);
    }
  }