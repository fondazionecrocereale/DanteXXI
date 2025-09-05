import 'dart:convert';
import 'package:crypto/crypto.dart';

class DIDService {
  static const String _didPrefix = 'did:fiorino:';

  /// Genera un DID determinístico basado en el email del usuario
  static String generateDID(String email) {
    // Normalizar email (lowercase, trim)
    final normalizedEmail = email.toLowerCase().trim();

    // Crear hash del email
    final bytes = utf8.encode(normalizedEmail);
    final digest = sha256.convert(bytes);

    // Tomar los primeros 16 bytes del hash para crear un ID más corto
    final id = digest.bytes
        .take(16)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return '$_didPrefix$id';
  }

  /// Valida si un DID tiene el formato correcto
  static bool isValidDID(String did) {
    return did.startsWith(_didPrefix) && did.length == _didPrefix.length + 32;
  }

  /// Extrae el ID del DID
  static String extractIdFromDID(String did) {
    if (!isValidDID(did)) {
      throw ArgumentError('Invalid DID format');
    }
    return did.substring(_didPrefix.length);
  }

  /// Genera una dirección de billetera determinística basada en el DID
  static String generateWalletAddress(String did) {
    final id = extractIdFromDID(did);
    final bytes = utf8.encode(id);
    final digest = sha256.convert(bytes);

    // Crear una dirección tipo Cosmos (bech32)
    final addressBytes = digest.bytes.take(20).toList();
    return _encodeBech32('fiorino', addressBytes);
  }

  /// Codifica bytes en formato bech32 (simplificado)
  static String _encodeBech32(String prefix, List<int> data) {
    // Implementación simplificada de bech32
    // En producción, usaría la librería bech32 oficial
    final hex = data.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '$prefix${hex.substring(0, 8)}...${hex.substring(hex.length - 8)}';
  }
}
