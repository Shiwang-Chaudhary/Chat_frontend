import 'dart:async';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/location_permission.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:chat_backend/app/widgets/customMarker.dart';
import 'package:chat_backend/app/widgets/friendMarker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:widget_to_marker/widget_to_marker.dart';
class LocationScreenController extends GetxController {

  final logger = Logger();
  IO.Socket? socket;
  StreamSubscription<Position>? locationStream;
  GoogleMapController? mapController;
  final RxSet<Marker> markers = <Marker>{}.obs;
  BitmapDescriptor? myIcon;
  final Map<String, BitmapDescriptor> friendIconCache = {};
  @override
  void onInit() {
    super.onInit();
    initSystem();
  }

  Future<void> initSystem() async {
    try {
      await LocationPermissionService.requestLocationPermission();

      // ✅ Load marker icons once
      await loadMarkerIcons();

      // ✅ Connect socket
      initializeSocket();
    } catch (e) {
      logger.e("❌ Init error: $e");
    }
  }

  // -------------------------------
  // LOAD ICONS ONCE
  // -------------------------------
  Future<void> loadMarkerIcons() async {
    myIcon = await CustomMarker().toBitmapDescriptor();
    logger.i("✅ My Marker Icon Loaded");
  }

  Future<BitmapDescriptor> getFriendIcon(String name) async {
    // If already cached → return instantly
    if (friendIconCache.containsKey(name)) {
      return friendIconCache[name]!;
    }

    // Else create once
    final icon = await FriendMarker(name: name).toBitmapDescriptor();
    friendIconCache[name] = icon;

    logger.i("✅ Friend Marker Icon Cached for $name");
    return icon;
  }

  void initializeSocket() async {
    final token = await StorageService.getData("token");

    if (token == null) {
      logger.e("❌ Token not found, socket not connecting");
      return;
    }

    socket = IO.io(
      // "http://192.168.1.3:3000",
      "https://shiwang-chat-backend.onrender.com",
      IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableReconnection()
      .setReconnectionAttempts(10)
      .setReconnectionDelay(2000)
      .setAuth({"token": token})
      .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      logger.i("✅ Socket Connected Successfully");
      // Start everything AFTER connect
      fetchFriendLocations();
      listenFriendLocationUpdates();
      startSendingMyLocation();
    });

    socket!.onDisconnect((_) {
      logger.w("⚠️ Socket Disconnected");
    });
  }

  void startSendingMyLocation() {
    locationStream?.cancel();

    locationStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 16,
      ),
    ).listen((position) {
      logger.i("📍 My Location: ${position.latitude}, ${position.longitude}");

      updateMyMarker(position);

      socket?.emit("updateLocation", {
        "latitude": position.latitude,
        "longitude": position.longitude,
      });
      logger.w("🚀 SENT TO SERVER: ${position.latitude}, ${position.longitude}");

    });

    logger.i("✅ Started sending live location");
  }

  void updateMyMarker(Position position) {
    const myMarkerId = "me";

    markers.removeWhere((m) => m.markerId.value == myMarkerId);

    markers.add(
      Marker(
        markerId: const MarkerId(myMarkerId),
        position: LatLng(position.latitude, position.longitude),
        icon: myIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "My Location"),
      ),
    );

    markers.refresh();

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        10,
      ),
    );
  }

  Future<void> fetchFriendLocations() async {
    try {
      final token = await StorageService.getData("token");

      final response = await ApiService.get(
        ApiEndpoints.getFriendsLocation,
        token,
      );

      logger.i("🌍 Friend Locations Response: $response");

      if (response == null || response["data"] == null) return;

      for (var friend in response["data"]) {
        updateFriendMarker(friend);
      }
    } catch (e) {
      logger.e("❌ Error fetching friend locations: $e");
    }
  }

  // -------------------------------
  // UPDATE FRIEND MARKER
  // -------------------------------
  void updateFriendMarker(dynamic data) async {
    final userId = data["user"] is Map ? data["user"]["_id"] : data["user"];
    final userName = data["user"] is Map ? data["user"]["name"] : "Friend";

    final latitude = (data["latitude"] as num).toDouble();
    final longitude = (data["longitude"] as num).toDouble();

    // ✅ Custom friend icon (cached)
    final friendIcon = await getFriendIcon(userName);

    markers.removeWhere((m) => m.markerId.value == userId);

    markers.add(
      Marker(
        markerId: MarkerId(userId),
        position: LatLng(latitude, longitude),
        icon: friendIcon,
        infoWindow: InfoWindow(title: userName),
      ),
    );

    markers.refresh();
  }

  void listenFriendLocationUpdates() {
    socket?.on("friendLocationUpdate", (data) {
      logger.i("📡 Friend Location Update: $data");
      updateFriendMarker(data);
    });
  }

  @override
  void onClose() {
    //don't disconnect socket
    // socket?.disconnect();
    locationStream?.cancel();
    mapController?.dispose();
    super.onClose();
  }
}
