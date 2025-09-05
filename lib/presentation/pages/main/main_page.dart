import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/wallet/wallet_bloc.dart';
import '../../bloc/transactions/transactions_bloc.dart';
import '../../bloc/swap/swap_bloc.dart';
import '../../bloc/rewards/rewards_bloc.dart';
import '../wallet/wallet_page.dart';
import '../swap/swap_page.dart';
import '../transactions/transactions_page.dart';
import '../rewards/rewards_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const WalletPage(),
    const SwapPage(),
    const TransactionsPage(),
    const RewardsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(context.read(), context.read()),
        ),
        BlocProvider<TransactionsBloc>(
          create: (context) => TransactionsBloc(context.read(), context.read()),
        ),
        BlocProvider<SwapBloc>(
          create: (context) => SwapBloc(context.read(), context.read()),
        ),
        BlocProvider<RewardsBloc>(
          create: (context) => RewardsBloc(context.read(), context.read()),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Billetera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Swap',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Transacciones',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Recompensas',
            ),
          ],
        ),
      ),
    );
  }
}
