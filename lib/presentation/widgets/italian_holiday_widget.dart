import 'package:flutter/material.dart';
import '../../core/services/italian_holidays_service.dart';
import '../../domain/entities/italian_holiday.dart';
import '../../core/constants/app_colors.dart';

class ItalianHolidayWidget extends StatefulWidget {
  const ItalianHolidayWidget({super.key});

  @override
  State<ItalianHolidayWidget> createState() => _ItalianHolidayWidgetState();
}

class _ItalianHolidayWidgetState extends State<ItalianHolidayWidget> {
  ItalianHoliday? _todayHoliday;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodayHoliday();
  }

  Future<void> _loadTodayHoliday() async {
    try {
      final holiday = await ItalianHolidaysService.getTodayHoliday();
      setState(() {
        _todayHoliday = holiday;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading today holiday: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si no hay festivo hoy, no mostrar nada
    if (_isLoading || _todayHoliday == null) {
      return const SizedBox.shrink();
    }

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
            // Header con icono y título
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.celebration,
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
                        '🎉 Festa Italiana',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      Text(
                        _todayHoliday!.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Mensaje del festivo
            Text(
              _todayHoliday!.message,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            // Indicador de fecha
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  'Oggi',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
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
}
