import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../../../domain/entities/user.dart';

class UserWeb3Info extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserWeb3Info({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.fingerprint,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Identidad Descentralizada',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // DID
            _buildInfoRow(
              context,
              'DID',
              user['did'] ?? 'Generando...',
              Icons.verified_user,
            ),

            const SizedBox(height: 12),

            // Wallet Address
            _buildInfoRow(
              context,
              'Dirección de Billetera',
              user['walletAddress'] ?? 'Generando...',
              Icons.account_balance_wallet,
              onTap: () =>
                  _copyToClipboard(context, user['walletAddress'] ?? ''),
            ),

            const SizedBox(height: 12),

            // Web3 Status
            Row(
              children: [
                Icon(
                  user['isWeb3Enabled'] == true
                      ? Icons.check_circle
                      : Icons.pending,
                  color: user['isWeb3Enabled'] == true
                      ? Colors.green
                      : Colors.orange,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  user['isWeb3Enabled'] == true
                      ? 'Web3 Habilitado'
                      : 'Web3 Pendiente',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: user['isWeb3Enabled'] == true
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.copy,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dirección copiada al portapapeles'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
