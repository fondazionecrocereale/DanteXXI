import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection_container.dart' as di;
import 'core/services/storage_service.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar servicios de almacenamiento
  await StorageService.init();

  // Inicializar dependencias
  await di.init();

  runApp(const DanteXXIApp());
}

class DanteXXIApp extends StatelessWidget {
  const DanteXXIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'DanteXXI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
