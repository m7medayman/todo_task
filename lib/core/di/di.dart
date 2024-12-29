import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/api/app_interceptors.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';
import 'package:task/features/add_task/data/add_edit_task_repo.dart';
import 'package:task/features/delete_task/delete_task_api.dart';
import 'package:task/features/home/data/home_repo.dart';
import 'package:task/features/home/presentation/cubit/home_cubit.dart';
import 'package:task/features/login/data/login_repo.dart';
import 'package:task/features/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/signup/data/signup_repo.dart';
import 'package:task/features/signup/presentation/cubit/singup_cubit.dart';

GetIt getIt = GetIt.instance;

bool isInitialized = false;
void initModule() {
  if (isInitialized) {
    return;
  }
  getIt.registerSingleton(SecureStorage());
  getIt.registerFactory(() => Dio(
        BaseOptions(
            baseUrl: EndPoints.baseUrl,
            responseType: ResponseType.plain,
            followRedirects: false),
      ));
  getIt.registerFactory(
      () => MyAppInterceptors(getIt<SecureStorage>(), client: getIt<Dio>()));
  getIt.registerFactory(() => LogInterceptor());
  getIt.registerFactory(() => DioConsumer(
      client: getIt<Dio>(),
      logInterceptor: getIt<LogInterceptor>(),
      appIntercepters: getIt<MyAppInterceptors>()));
  isInitialized = true;
}

class AppInterceptors {}

bool isLoginInit = false;

void initLoginModule() {
  if (isLoginInit) {
    return;
  }
  isLoginInit = true;
  getIt
      .registerFactory(() => LoginRepo(storage: getIt(), dioConsumer: getIt()));
  getIt.registerFactory(() => LoginCubit(getIt<LoginRepo>()));
}

bool isSignupInit = false;

void initSignupModule() {
  if (isSignupInit) {
    return;
  }
  isSignupInit = true;
  getIt.registerFactory(
      () => SignupRepo(storage: getIt(), dioConsumer: getIt()));
  getIt.registerFactory(() => SingupCubit(getIt<SignupRepo>()));
}

bool isDelteInit = false;
void initDeleteRepo() {
  if (isDelteInit) {
    return;
  }
  getIt
      .registerFactory(() => DeleteTaskRepo(dioConsumer: getIt<DioConsumer>()));
}

bool isHomeModuleInit = false;
void initHomeModule() {
  if (isHomeModuleInit) {
    return;
  }
  initDeleteRepo();
  getIt.registerFactory(() => HomeRepo(dioConsumer: getIt<DioConsumer>()));
  getIt.registerFactory(() => HomeCubit(
      getIt<HomeRepo>(), getIt<DeleteTaskRepo>(), getIt<SecureStorage>()));
  isHomeModuleInit = true;
}

bool isAddTaskModuleInit = false;

void initAddMoudle() {
  if (isAddTaskModuleInit) {
    return;
  }
  getIt.registerFactory(
      () => AddEditTaskRepo(dioConsumer: getIt<DioConsumer>()));
  isAddTaskModuleInit = true;
}
