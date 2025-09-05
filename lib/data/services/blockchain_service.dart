import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

@injectable
class BlockchainService {
  // Configuración de la red Fiorino (Cosmos SDK)
  static const String _rpcUrl = 'http://localhost:26657';
  static const String _restUrl = 'http://localhost:1317';
  static const String _chainId = 'fiorino-1';
  static const String _denom = 'ufiorino';
  static const String _addressPrefix = 'fiorino';

  // Obtener balance de Fiorino
  Future<int> getBalance(String address) async {
    try {
      final response = await http.get(
        Uri.parse('$_restUrl/cosmos/bank/v1beta1/balances/$address'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final balances = data['balances'] as List;

        for (final balance in balances) {
          if (balance['denom'] == _denom) {
            return int.parse(balance['amount'] as String);
          }
        }
        return 0;
      }
    } catch (e) {
      // Para demo, devolver balance simulado
      print('Error obteniendo balance: $e');
    }

    // Balance simulado para demostración
    return 1000000000; // 1000 FIORINO en microunidades
  }

  // Obtener precio de Fiorino en USD
  Future<double> getFiorinoPrice() async {
    try {
      // En producción, esto vendría de un oracle de precios
      // Por ahora usamos un precio simulado
      return 0.50; // $0.50 USD por FIORINO
    } catch (e) {
      return 0.50;
    }
  }

  // Enviar tokens
  Future<String> sendTokens({
    required String toAddress,
    required int amount,
    String? memo,
  }) async {
    try {
      // Crear la transacción Cosmos
      final transaction = {
        'body': {
          'messages': [
            {
              '@type': '/cosmos.bank.v1beta1.MsgSend',
              'from_address': 'fiorino1demo123', // Dirección simulada
              'to_address': toAddress,
              'amount': [
                {'denom': _denom, 'amount': amount.toString()},
              ],
            },
          ],
          'memo': memo ?? '',
          'timeout_height': '0',
          'extension_options': [],
          'non_critical_extension_options': [],
        },
        'auth_info': {
          'signer_infos': [],
          'fee': {
            'amount': [
              {
                'denom': _denom,
                'amount': '1000', // Fee fijo
              },
            ],
            'gas_limit': '200000',
            'payer': '',
            'granter': '',
          },
        },
        'signatures': [],
      };

      // Simular envío de transacción
      await Future.delayed(const Duration(seconds: 2));

      return 'fiorino_tx_${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      throw Exception('Error al enviar tokens: $e');
    }
  }

  // Obtener historial de transacciones
  Future<List<Map<String, dynamic>>> getTransactionHistory(
    String address,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_restUrl/cosmos/tx/v1beta1/txs?events=transfer.recipient=\'$address\'',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['tx_responses'] ?? []);
      }
    } catch (e) {
      // Devolver transacciones simuladas
    }

    // Datos simulados para demostración
    return [
      {
        'txhash': 'ABC123',
        'height': '12345',
        'timestamp': DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/cosmos.bank.v1beta1.MsgSend',
                'from_address': 'fiorino1sender123',
                'to_address': address,
                'amount': [
                  {'denom': _denom, 'amount': '500000'},
                ],
              },
            ],
          },
        },
      },
      {
        'txhash': 'DEF456',
        'height': '12340',
        'timestamp': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/cosmos.bank.v1beta1.MsgSend',
                'from_address': address,
                'to_address': 'fiorino1receiver456',
                'amount': [
                  {'denom': _denom, 'amount': '1000000'},
                ],
              },
            ],
          },
        },
      },
    ];
  }

  // Crear swap con MercadoPago
  Future<Map<String, dynamic>> createSwap({
    required double mercadopagoAmount,
    required int fiorinoAmount,
  }) async {
    try {
      // Crear transacción de swap en la blockchain
      final swapTx = {
        'body': {
          'messages': [
            {
              '@type': '/fiorino.fiorino.MsgCreateSwap',
              'creator': 'fiorino1demo123',
              'mercadopago_amount': mercadopagoAmount.toString(),
              'fiorino_amount': fiorinoAmount.toString(),
              'mercadopago_tx_id':
                  'mp_${DateTime.now().millisecondsSinceEpoch}',
              'status': 'pending',
            },
          ],
          'memo': 'Swap MercadoPago to Fiorino',
        },
      };

      // Simular creación del swap
      await Future.delayed(const Duration(seconds: 2));

      return {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'status': 'completed',
        'txhash': 'swap_tx_${DateTime.now().millisecondsSinceEpoch}',
        'mercadopago_amount': mercadopagoAmount,
        'fiorino_amount': fiorinoAmount,
        'created_at': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception('Error al crear swap: $e');
    }
  }

  // Obtener información de la red
  Future<Map<String, dynamic>> getNetworkInfo() async {
    return {
      'chain_id': _chainId,
      'denom': _denom,
      'rpc_url': _rpcUrl,
      'rest_url': _restUrl,
      'block_height': Random().nextInt(100000) + 50000,
      'validators': 21,
      'status': 'online',
    };
  }

  // Validar dirección de Fiorino
  bool isValidAddress(String address) {
    return address.startsWith(_addressPrefix) && address.length == 45;
  }

  // Convertir microunidades a unidades completas
  double microToFiorino(int micro) {
    return micro / 1000000;
  }

  // Convertir unidades completas a microunidades
  int fiorinoToMicro(double fiorino) {
    return (fiorino * 1000000).round();
  }
}
