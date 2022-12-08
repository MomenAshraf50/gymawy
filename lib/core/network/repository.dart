import '/core/network/remote/dio_helper.dart';
import 'local/cache_helper.dart';

abstract class Repository {}

class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });
}
