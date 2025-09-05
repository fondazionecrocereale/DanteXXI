import 'package:shared_preferences/shared_preferences.dart';
import 'did_service.dart';
import '../../domain/entities/user.dart';

class UserMigrationService {
  static const String _migrationKey = 'user_migration_completed';

  /// Migra usuarios existentes para agregar campos Web3
  static Future<User> migrateUser(User user) async {
    // Verificar si ya fue migrado
    final prefs = await SharedPreferences.getInstance();
    final migrationCompleted =
        prefs.getBool('${_migrationKey}_${user.id}') ?? false;

    if (migrationCompleted && user.did != null) {
      return user; // Ya migrado
    }

    // Generar DID y wallet address si no existen
    final did = user.did ?? DIDService.generateDID(user.email);
    final walletAddress =
        user.walletAddress ?? DIDService.generateWalletAddress(did);

    // Crear usuario migrado
    final migratedUser = user.copyWith(
      did: did,
      walletAddress: walletAddress,
      isWeb3Enabled: true,
    );

    // Marcar como migrado
    await prefs.setBool('${_migrationKey}_${user.id}', true);

    return migratedUser;
  }

  /// Verifica si un usuario necesita migración
  static bool needsMigration(User user) {
    return user.did == null || user.walletAddress == null;
  }

  /// Obtiene la dirección de billetera del usuario (migrada o nueva)
  static String getUserWalletAddress(User user) {
    if (user.walletAddress != null) {
      return user.walletAddress!;
    }

    // Generar temporalmente si no existe
    final did = user.did ?? DIDService.generateDID(user.email);
    return DIDService.generateWalletAddress(did);
  }
}
