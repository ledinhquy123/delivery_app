import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:user_app/app_export.dart';
import 'package:user_app/configs/configs_export.dart';
import 'package:user_app/constants/constants_export.dart';
import 'package:user_app/features/home_screen/home_screen.dart';

class ConnectToPusher {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  getSignature(String value) {
    var key = utf8.encode(PUSHER_APP_SECRET);
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    return digest;
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "$PUSHER_APP_KEY:${getSignature("$socketId:$channelName")}",
      "shared_secret": "6057722b686f66a9ff85"
    };
  }

  void connecToPusher() async {
    try {
      await pusher.init(
        apiKey: PUSHER_APP_KEY,
        cluster: CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        onAuthorizer: (channelName, socketId, options) =>
            onAuthorizer(channelName, socketId, options),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getInt('id') != null) {
        await pusher.subscribe(
            channelName: 'private-place-an-order.${prefs.getInt('id')}',
            onEvent: (event) {
              var ans = jsonDecode(event.data);
              if (ans['data'] != null) {
                prefs.setString('order', jsonEncode(ans['data']));
                navigatorKey.currentState
                    ?.pushReplacementNamed(HomeScreen.routeName);
              }
            });
      }

      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  dynamic subscribeEvent(String channelName) async {
    // connecToPusher();
    await pusher.subscribe(
        channelName: channelName,
        onEvent: (event) {
          if (!event) return null;
          log(jsonDecode(event.data));
          return jsonDecode(event.data);
        });
  }

  void disConnectPusher() async {
    await pusher.disconnect();
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }
}
