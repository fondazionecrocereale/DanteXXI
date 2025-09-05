import 'package:injectable/injectable.dart';

import '../../entities/swap.dart';
import '../../repositories/swap_repository.dart';

@injectable
class CreateSwapUsecase {
  final SwapRepository _swapRepository;

  CreateSwapUsecase(this._swapRepository);

  Future<Swap> call({
    required double mercadopagoAmount,
    required int fiorinoAmount,
    required double exchangeRate,
  }) async {
    return await _swapRepository.createSwap(
      mercadopagoAmount: mercadopagoAmount,
      fiorinoAmount: fiorinoAmount,
      exchangeRate: exchangeRate,
    );
  }
}
