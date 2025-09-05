class AppConfig {
  // Configuración de la blockchain Fiorino
  static const String blockchainRpcUrl = 'http://localhost:26657';
  static const String blockchainRestUrl = 'http://localhost:1317';
  static const String chainId = 'fiorino-1';
  static const String denom = 'ufiorino';
  static const String addressPrefix = 'fiorino';

  // Configuración de MercadoPago
  static const String mercadoPagoBaseUrl = 'https://api.mercadopago.com';
  static const String mercadoPagoSandboxUrl = 'https://sandbox.mercadopago.com';

  // Estas claves deben configurarse como variables de entorno en producción
  static const String mercadoPagoAccessToken = String.fromEnvironment(
    'MERCADOPAGO_ACCESS_TOKEN',
    defaultValue: 'TEST-YOUR-ACCESS-TOKEN',
  );

  static const String mercadoPagoPublicKey = String.fromEnvironment(
    'MERCADOPAGO_PUBLIC_KEY',
    defaultValue: 'TEST-YOUR-PUBLIC-KEY',
  );

  // URLs de webhook y callback
  static const String webhookUrl = 'https://fiorino-wallet.com/webhook';
  static const String successUrl = 'https://fiorino-wallet.com/success';
  static const String failureUrl = 'https://fiorino-wallet.com/failure';
  static const String pendingUrl = 'https://fiorino-wallet.com/pending';

  // Configuración de la aplicación
  static const String appName = 'Fiorino Wallet';
  static const String appVersion = '1.0.0';
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );
  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );

  // Parámetros del token
  static const int decimals = 6; // Fiorino usa 6 decimales (microunidades)
  static const String tokenSymbol = 'FIORINO';
  static const String tokenName = 'Fiorino d\'oro';

  // Configuración de fees
  static const int defaultFee = 1000; // 0.001 FIORINO en microunidades
  static const int gasLimit = 200000;

  // Configuración de intercambio
  static const double defaultExchangeRate = 0.001; // 1 ARS = 0.001 FIORINO
  static const double minSwapAmount = 100.0; // Mínimo 100 ARS
  static const double maxSwapAmount = 100000.0; // Máximo 100,000 ARS
  static const double swapFeePercentage = 0.01; // 1% de fee

  // Configuración de seguridad
  static const int sessionTimeoutMinutes = 30;
  static const int maxRetryAttempts = 3;
  static const int requestTimeoutSeconds = 30;

  // URLs de documentación y soporte
  static const String documentationUrl = 'https://docs.fiorino-wallet.com';
  static const String supportUrl = 'https://support.fiorino-wallet.com';
  static const String termsUrl = 'https://fiorino-wallet.com/terms';
  static const String privacyUrl = 'https://fiorino-wallet.com/privacy';

  // Configuración de notificaciones
  static const bool enablePushNotifications = true;
  static const bool enableEmailNotifications = true;

  // Validadores
  static bool isValidFiorinoAddress(String address) {
    return address.startsWith(addressPrefix) &&
        address.length == 45 &&
        RegExp(
          r'^[a-z0-9]+$',
        ).hasMatch(address.substring(addressPrefix.length));
  }

  static bool isValidAmount(double amount) {
    return amount > 0 && amount <= maxSwapAmount;
  }

  static bool isValidSwapAmount(double arsAmount) {
    return arsAmount >= minSwapAmount && arsAmount <= maxSwapAmount;
  }

  // Convertidores de unidades
  static int fiorinoToMicro(double fiorino) {
    return (fiorino * 1000000).round();
  }

  static double microToFiorino(int micro) {
    return micro / 1000000;
  }

  // Formatters
  static String formatFiorinoAmount(int microAmount) {
    final fiorino = microToFiorino(microAmount);
    return '${fiorino.toStringAsFixed(6)} $tokenSymbol';
  }

  static String formatArsAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)} ARS';
  }

  // Configuración de red
  static Map<String, String> getNetworkConfig() {
    return {
      'rpc_url': blockchainRpcUrl,
      'rest_url': blockchainRestUrl,
      'chain_id': chainId,
      'denom': denom,
      'address_prefix': addressPrefix,
    };
  }

  // Configuración de MercadoPago
  static Map<String, String> getMercadoPagoConfig() {
    return {
      'base_url': isProduction ? mercadoPagoBaseUrl : mercadoPagoSandboxUrl,
      'access_token': mercadoPagoAccessToken,
      'public_key': mercadoPagoPublicKey,
      'webhook_url': webhookUrl,
    };
  }

  // Verificar si la configuración está completa
  static bool isConfigurationValid() {
    return mercadoPagoAccessToken != 'TEST-YOUR-ACCESS-TOKEN' &&
        mercadoPagoPublicKey != 'TEST-YOUR-PUBLIC-KEY';
  }

  // Obtener configuración de debug
  static Map<String, dynamic> getDebugInfo() {
    return {
      'app_name': appName,
      'app_version': appVersion,
      'is_production': isProduction,
      'blockchain_rpc': blockchainRpcUrl,
      'mercadopago_configured': isConfigurationValid(),
      'chain_id': chainId,
      'denom': denom,
    };
  }
}
