import 'package:injectable/injectable.dart';

import '../../entities/swap.dart';
import '../../repositories/swap_repository.dart';

@injectable
class GetSwapsUsecase {
  final SwapRepository _swapRepository;

  GetSwapsUsecase(this._swapRepository);

  Future<List<Swap>> call() async {
    return await _swapRepository.getSwaps();
  }
}
