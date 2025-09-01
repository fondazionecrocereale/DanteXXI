import 'package:flutter/material.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/italian_facts_service.dart';
import '../../core/constants/app_colors.dart';

class NotificationTestWidget extends StatefulWidget {
  const NotificationTestWidget({super.key});

  @override
  State<NotificationTestWidget> createState() => _NotificationTestWidgetState();
}

class _NotificationTestWidgetState extends State<NotificationTestWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue.withValues(alpha: 0.1),
            AppColors.primaryBlue.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.notifications_active,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🔔 Notificaciones de Facts',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      Text(
                        'Prueba las notificaciones italianas',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: _buildNotificationButton(
                    'Notificación Inmediata',
                    Icons.notification_important,
                    () => _showImmediateNotification(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNotificationButton(
                    'Notificación en 5s',
                    Icons.schedule,
                    () => _scheduleRandomNotification(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _buildNotificationButton(
                    'Programar Diaria',
                    Icons.calendar_today,
                    () => _scheduleDailyNotification(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNotificationButton(
                    'Cancelar Todas',
                    Icons.cancel,
                    () => _cancelAllNotifications(),
                    isDestructive: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton(
    String text,
    IconData icon,
    VoidCallback onPressed, {
    bool isDestructive = false,
  }) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : onPressed,
      icon: Icon(
        icon,
        size: 16,
        color: isDestructive ? Colors.white : AppColors.primaryBlue,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.white : AppColors.primaryBlue,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDestructive
            ? Colors.red
            : AppColors.primaryBlue.withValues(alpha: 0.1),
        foregroundColor: isDestructive ? Colors.white : AppColors.primaryBlue,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _showImmediateNotification() async {
    setState(() => _isLoading = true);

    try {
      await NotificationService.showImmediateFactNotification();
      _showSnackBar('✅ Notificación inmediata enviada');
    } catch (e) {
      _showSnackBar('❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _scheduleRandomNotification() async {
    setState(() => _isLoading = true);

    try {
      await NotificationService.scheduleRandomFactNotification();
      _showSnackBar('✅ Notificación programada para 5 segundos');
    } catch (e) {
      _showSnackBar('❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _scheduleDailyNotification() async {
    setState(() => _isLoading = true);

    try {
      await NotificationService.scheduleDailyFactNotification();
      _showSnackBar('✅ Notificación diaria programada para las 9:00 AM');
    } catch (e) {
      _showSnackBar('❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _cancelAllNotifications() async {
    setState(() => _isLoading = true);

    try {
      await NotificationService.cancelAllNotifications();
      _showSnackBar('✅ Todas las notificaciones canceladas');
    } catch (e) {
      _showSnackBar('❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}


