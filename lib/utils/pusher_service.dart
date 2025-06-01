import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  late PusherChannelsFlutter pusher;
  PusherChannel? pusherChannel;

  PusherService() {
    _initializePusher();
  }

  Future<void> _initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: '///',
        cluster: 'ap2',
      );
      await pusher.connect();
    } catch (e) {
      print("Error initializing Pusher: $e");
    }
  }

  Future<void> bind(String channelName, Function(PusherEvent) callback) async {
    try {
      pusherChannel = await pusher.subscribe(
        channelName: channelName,
        onEvent: (event) => callback(event),
      );
    } catch (e) {
      print("Error subscribing to channel: $e");
    }
  }

  void unbind() {
    pusherChannel?.unsubscribe();
  }

  void disconnect() {
    pusher.disconnect();
  }
}
