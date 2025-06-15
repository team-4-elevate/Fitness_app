// features/auth/data/repo/auth_repo_impl.dart
import 'package:fitness_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthLocalDataSourceContract authLocalDataSource;
  final AuthRemoteDataSourceContract authRemoteDataSource;

  AuthRepoImpl(this.authLocalDataSource, this.authRemoteDataSource);



}