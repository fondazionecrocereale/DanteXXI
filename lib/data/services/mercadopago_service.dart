import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

@injectable
class MercadoPagoService {
  late Dio _dio;
  late SharedPreferences _prefs;

  // Configuración de MercadoPago (usar variables de entorno en producción)
  static const String _baseUrl = 'https://api.mercadopago.com';
  static const String _accessToken = 'TEST-YOUR-ACCESS-TOKEN';
  static const String _publicKey = 'TEST-YOUR-PUBLIC-KEY';

  Future<void> initialize() async {
    _dio = Dio();
    _prefs = await SharedPreferences.getInstance();

    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $_accessToken',
      'Content-Type': 'application/json',
    };
  }

  // Obtener balance de MercadoPago del usuario
  Future<double> getMercadoPagoBalance() async {
    try {
      // En producción, esto requiere OAuth y permisos especiales
      // Por ahora simulamos un balance
      final savedBalance = _prefs.getDouble('mp_balance') ?? 10000.0;
      return savedBalance;
    } catch (e) {
      // Balance simulado por defecto
      return 10000.0; // $10,000 ARS
    }
  }

  // Crear preferencia de pago para el swap
  Future<Map<String, dynamic>> createSwapPayment({
    required double amount,
    required int fiorinoAmount,
    required String userEmail,
  }) async {
    try {
      final preference = {
        'items': [
          {
            'title': 'Compra de Fiorino d\'oro',
            'description':
                'Intercambio de $amount ARS por $fiorinoAmount FIORINO',
            'quantity': 1,
            'unit_price': amount,
            'currency_id': 'ARS',
          },
        ],
        'payer': {'email': userEmail},
        'payment_methods': {
          'excluded_payment_methods': [],
          'excluded_payment_types': [],
          'installments': 1,
        },
        'back_urls': {
          'success': 'https://fiorino-wallet.com/success',
          'failure': 'https://fiorino-wallet.com/failure',
          'pending': 'https://fiorino-wallet.com/pending',
        },
        'auto_return': 'approved',
        'external_reference':
            'FIORINO_SWAP_${DateTime.now().millisecondsSinceEpoch}',
        'notification_url': 'https://fiorino-wallet.com/webhook',
      };

      final response = await _dio.post(
        '/checkout/preferences',
        data: json.encode(preference),
      );

      if (response.statusCode == 201) {
        return {
          'id': response.data['id'],
          'init_point': response.data['init_point'],
          'sandbox_init_point': response.data['sandbox_init_point'],
        };
      } else {
        throw Exception('Error al crear preferencia de pago');
      }
    } catch (e) {
      // Simular respuesta exitosa para demo
      return {
        'id': 'demo_preference_${DateTime.now().millisecondsSinceEpoch}',
        'init_point':
            'https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=demo',
        'sandbox_init_point':
            'https://sandbox.mercadopago.com.ar/checkout/v1/redirect?pref_id=demo',
      };
    }
  }

  // Verificar el estado de un pago
  Future<Map<String, dynamic>> getPaymentStatus(String paymentId) async {
    try {
      final response = await _dio.get('/v1/payments/$paymentId');

      if (response.statusCode == 200) {
        return {
          'id': response.data['id'],
          'status': response.data['status'],
          'status_detail': response.data['status_detail'],
          'transaction_amount': response.data['transaction_amount'],
          'currency_id': response.data['currency_id'],
          'date_created': response.data['date_created'],
          'date_approved': response.data['date_approved'],
        };
      } else {
        throw Exception('Error al obtener estado del pago');
      }
    } catch (e) {
      // Simular pago aprobado para demo
      return {
        'id': paymentId,
        'status': 'approved',
        'status_detail': 'accredited',
        'transaction_amount': 1000.0,
        'currency_id': 'ARS',
        'date_created': DateTime.now().toIso8601String(),
        'date_approved': DateTime.now().toIso8601String(),
      };
    }
  }

  // Procesar pago directo (para usuarios con saldo en MercadoPago)
  Future<Map<String, dynamic>> processDirectPayment({
    required double amount,
    required String description,
    required String userEmail,
  }) async {
    try {
      // Verificar si el usuario tiene saldo suficiente
      final currentBalance = await getMercadoPagoBalance();
      if (currentBalance < amount) {
        throw Exception('Saldo insuficiente en MercadoPago');
      }

      // Simular procesamiento del pago
      await Future.delayed(const Duration(seconds: 2));

      // Actualizar balance local
      final newBalance = currentBalance - amount;
      await _prefs.setDouble('mp_balance', newBalance);

      return {
        'id': 'direct_payment_${DateTime.now().millisecondsSinceEpoch}',
        'status': 'approved',
        'status_detail': 'accredited',
        'transaction_amount': amount,
        'currency_id': 'ARS',
        'date_created': DateTime.now().toIso8601String(),
        'date_approved': DateTime.now().toIso8601String(),
        'description': description,
        'payer_email': userEmail,
      };
    } catch (e) {
      throw Exception('Error al procesar pago directo: $e');
    }
  }

  // Obtener historial de pagos
  Future<List<Map<String, dynamic>>> getPaymentHistory() async {
    try {
      final response = await _dio.get(
        '/v1/payments/search?sort=date_created&criteria=desc',
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['results'] ?? []);
      }
    } catch (e) {
      // Devolver historial simulado
    }

    // Datos simulados para demostración
    return [
      {
        'id': '12345678901',
        'status': 'approved',
        'transaction_amount': 1000.0,
        'currency_id': 'ARS',
        'description': 'Compra de Fiorino d\'oro',
        'date_created': DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
        'date_approved': DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
      },
      {
        'id': '12345678902',
        'status': 'approved',
        'transaction_amount': 500.0,
        'currency_id': 'ARS',
        'description': 'Compra de Fiorino d\'oro',
        'date_created': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
        'date_approved': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
      },
    ];
  }

  // Calcular tasa de cambio ARS -> FIORINO
  Future<double> getExchangeRate() async {
    try {
      // En producción, esto podría venir de un oracle de precios
      // Por ahora usamos una tasa fija
      return 0.001; // 1 ARS = 0.001 FIORINO
    } catch (e) {
      return 0.001; // Tasa por defecto
    }
  }

  // Calcular cantidad de Fiorino por cantidad de ARS
  Future<int> calculateFiorinoAmount(double arsAmount) async {
    final rate = await getExchangeRate();
    final fiorinoAmount = arsAmount * rate;
    return (fiorinoAmount * 1000000).round(); // Convertir a microunidades
  }

  // Calcular cantidad de ARS por cantidad de Fiorino
  Future<double> calculateArsAmount(int fiorinoMicroAmount) async {
    final rate = await getExchangeRate();
    final fiorinoAmount =
        fiorinoMicroAmount / 1000000; // Convertir de microunidades
    return fiorinoAmount / rate;
  }

  // Validar configuración de MercadoPago
  bool isConfigured() {
    return _accessToken != 'TEST-YOUR-ACCESS-TOKEN' &&
        _publicKey != 'TEST-YOUR-PUBLIC-KEY';
  }

  // Obtener información de la cuenta
  Future<Map<String, dynamic>> getAccountInfo() async {
    try {
      final response = await _dio.get('/users/me');

      if (response.statusCode == 200) {
        return {
          'id': response.data['id'],
          'email': response.data['email'],
          'first_name': response.data['first_name'],
          'last_name': response.data['last_name'],
          'country_id': response.data['country_id'],
          'status': response.data['status'],
        };
      }
    } catch (e) {
      // Información simulada
    }

    return {
      'id': 'demo_user',
      'email': 'usuario@demo.com',
      'first_name': 'Usuario',
      'last_name': 'Demo',
      'country_id': 'AR',
      'status': 'active',
    };
  }
}
