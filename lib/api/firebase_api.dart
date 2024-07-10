import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pandemonium/main.dart';


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // function to initialize notifications
  
  Future<void> initNotifications() async {
    // request permission from the user (will prompt user)
    await _firebaseMessaging.requestPermission();
    // fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();
    // print the token (normally you would send this to your server)
    print('Firebase Messaging Token: $fCMToken');

    // intialize further settings for push noti
    initPushNotifications();
  }

  //function to handle received messages
  void handleMessage(RemoteMessage? message) {
    // if the message is null, do nothing
    if (message == null) {
      return;
    }
    // navigate to the new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
      );
  }
  // function to initialize bacground settings
  Future initPushNotifications() async {
    // handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // attack even listeners for when a notification opnes the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}