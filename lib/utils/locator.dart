import 'package:CourseMate/services/analytics_service.dart';
import 'package:CourseMate/services/authentication_service.dart';
import 'package:CourseMate/services/cloud_storage_service.dart';
import 'package:CourseMate/services/dynamic_link_service.dart';
import 'package:CourseMate/services/firestore_service.dart';
import 'package:CourseMate/services/push_notification_service.dart';
import 'package:CourseMate/services/remote_config_service.dart';
import 'package:CourseMate/utils/image_selector.dart';
import 'package:get_it/get_it.dart';
import 'package:CourseMate/services/navigation_service.dart';
import 'package:CourseMate/services/dialog_service.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => DynamicLinkService());

  var remoteConfigService = await RemoteConfigService.getInstance();
  locator.registerSingleton(remoteConfigService);
}
