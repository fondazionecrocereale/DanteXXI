# Ejemplo de Uso de la Billetera Fiorino

## Descripción

La billetera Fiorino es un sistema completo de gestión de tokens basado en Cosmos SDK que permite a los usuarios:

- Ver su balance de tokens Fiorino d'oro
- Intercambiar saldo de MercadoPago por tokens Fiorino
- Enviar y recibir tokens
- Ver historial de transacciones
- Reclamar recompensas por completar cursos

## Características Principales

### 1. Balance de Billetera
- Muestra el balance actual en FIORINO y USD
- Precio actual del token
- Última actualización del balance

### 2. Intercambio (Swap)
- Conversión de ARS (MercadoPago) a FIORINO
- Tasa de cambio en tiempo real
- Historial de intercambios realizados

### 3. Transacciones
- Envío de tokens a otras direcciones
- Recepción de tokens
- Historial completo de transacciones
- Estados: Pendiente, Confirmado, Fallido

### 4. Recompensas
- Recompensas por completar cursos
- Bonificaciones por login diario
- Recompensas por rachas de estudio
- Sistema de referidos

## Arquitectura

### Entidades del Dominio
- `WalletBalance`: Balance de la billetera
- `Transaction`: Transacciones de la billetera
- `Swap`: Intercambios con MercadoPago
- `Reward`: Recompensas del usuario

### Servicios
- `BlockchainService`: Interacción con la blockchain Cosmos
- `MercadoPagoService`: Integración con MercadoPago

### BLoCs
- `WalletBloc`: Gestión del balance
- `TransactionsBloc`: Gestión de transacciones
- `SwapBloc`: Gestión de intercambios
- `RewardsBloc`: Gestión de recompensas

## Configuración

### Variables de Entorno
```bash
MERCADOPAGO_ACCESS_TOKEN=your_access_token
MERCADOPAGO_PUBLIC_KEY=your_public_key
PRODUCTION=false
ENABLE_LOGGING=true
```

### Configuración de la Blockchain
```dart
static const String blockchainRpcUrl = 'http://localhost:26657';
static const String blockchainRestUrl = 'http://localhost:1317';
static const String chainId = 'fiorino-1';
static const String denom = 'ufiorino';
```

## Uso en la Aplicación

### 1. Navegación
La billetera se integra en la navegación principal con 4 pestañas:
- Billetera: Vista principal con balance y acciones rápidas
- Swap: Intercambio de ARS por FIORINO
- Transacciones: Historial de transacciones
- Recompensas: Sistema de recompensas

### 2. Acceso a la Billetera
```dart
Navigator.pushNamed(context, RouteGenerator.wallet);
```

### 3. Uso de BLoCs
```dart
// Cargar balance
context.read<WalletBloc>().add(
  const WalletEvent.loadRequested('fiorino1demo123')
);

// Crear swap
context.read<SwapBloc>().add(
  SwapEvent.createSwap(
    mercadopagoAmount: 1000.0,
    fiorinoAmount: 1000000,
    exchangeRate: 0.001,
  )
);

// Reclamar recompensa
context.read<RewardsBloc>().add(
  RewardsEvent.claimReward('reward_id')
);
```

## Integración con Cursos

### Recompensas por Cursos
- Al completar un curso, se otorga una recompensa en FIORINO
- Las recompensas se pueden reclamar desde la pestaña de Recompensas
- Sistema de expiración para recompensas no reclamadas

### Compra de Cursos
- Los usuarios pueden usar FIORINO para comprar cursos premium
- Integración con el sistema de pagos existente

## Seguridad

### Validación de Direcciones
- Validación de formato de direcciones Fiorino
- Verificación de checksum

### Gestión de Claves
- Almacenamiento seguro de claves privadas
- Encriptación de datos sensibles

## Monitoreo y Logs

### Logs de Transacciones
- Registro de todas las operaciones
- Trazabilidad completa de transacciones

### Métricas
- Balance total de usuarios
- Volumen de intercambios
- Recompensas distribuidas

## Próximas Funcionalidades

1. **Staking**: Participación en la red para ganar recompensas
2. **DeFi**: Funcionalidades de finanzas descentralizadas
3. **NFTs**: Tokens no fungibles para logros especiales
4. **Gobernanza**: Participación en decisiones de la red
5. **Integración con más exchanges**: Binance, Coinbase, etc.

## Soporte

Para soporte técnico o preguntas sobre la billetera:
- Email: support@fiorino-wallet.com
- Documentación: https://docs.fiorino-wallet.com
- GitHub: https://github.com/fiorino-wallet
