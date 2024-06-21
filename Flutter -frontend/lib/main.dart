import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hero/shared/shared.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hero/.env.dart';

import 'app_binding.dart';
import 'di.dart';
import 'lang/lang.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await DenpendencyInjection.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDgVg8L68dT1lsh-fcWAH71ih6_vkrJZDI',
    appId: '1:604664812017:android:d1496343c8c54ed425b450',
    authDomain: 'horecah-e959f.firebaseapp.com',
    messagingSenderId: '604664812017',
    androidClientId:
        "604664812017-uvf3ju1efa8666n3bcv4db4jio90vq8q.apps.googleusercontent.com",
    projectId: 'horecah-e959f',
    storageBucket: 'horecah-e959f.appspot.com',
  ));

  // Stripe.publishableKey =
  //     "pk_test_51P7KCMLvxyZE3ldUrkZ01p5ZYCy4x0lgoMWz6jPOY4XiJa7xgqmUkUpkH8r7VKh3NqQkxNj0HNL7TDVOA4wecS7Y00RPXLr5cE";

  runApp(App());
  configLoading();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorConstants.principalColor,
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: Routes.SPLASH,
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 200),
        getPages: AppPages.routes,
        initialBinding: AppBinding(),
        smartManagement: SmartManagement.keepFactory,
        title: 'horecah',
        theme: ThemeConfig.lightTheme,
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PaymentScreen(),
//     );
    
//   }
// }

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 20.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = Colors.blue[50]
    ..indicatorColor = ColorConstants.secondaryAppColor
    ..textColor = ColorConstants.secondaryAppColor
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
