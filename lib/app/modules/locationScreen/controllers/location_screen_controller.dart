import 'dart:async';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/location_permission.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LocationScreenController extends GetxController {
  StreamSubscription<Position>? locationStream;
  final logger = Logger();
  late IO.Socket socket;
  final RxSet<Marker> markers = <Marker>{}.obs;
  GoogleMapController? mapController; // ✅ ADD THIS

  @override
  void onInit() {
    super.onInit();
    initLocationSystem();
  }

  Future initLocationSystem() async {
    try {
      await LocationPermissionService.requestLocationPermission();
      initializeSocket();
    } catch (e) {
      logger.e("Init error ${e.toString()}");
    }
  }

  void initializeSocket() async {
    final token = await StorageService.getData("token");

    if (token == null) {
      logger.e("Token not found, socket not connecting");
      return;
    }

    socket = IO.io(
      "http://192.168.1.4:3000",
      IO.OptionBuilder().setTransports(['websocket']).setAuth({
        "token": token,
      }).build(),
    );

    socket.connect();

    socket.onConnect((_) {
      logger.i("✅ Connected to socket server with token");
      fetchFriendLocation();
      listenRealTimeFriendLocationUpdates();
      startSendingMyLocation();
    });
  }

  void updateMarker(dynamic data) async {
    final userId = data["user"] is Map ? data["user"]["_id"] : data["user"];
    final latitude = (data["latitude"] as num).toDouble();
    final longitude = (data["longitude"] as num).toDouble();
    //since marker is immutable, we need to remove the old marker and add a new marker with the updated location
    // logger.i("Updating marker for user: $userId with location: $latitude, $longitude");
    markers.removeWhere((marker) => marker.markerId.value == userId);
    markers.add(
      Marker(markerId: MarkerId(userId), position: LatLng(latitude, longitude)),
    );
    markers.refresh();
  }

  void startSendingMyLocation() {
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 20,
    );
    locationStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (position) {
            logger.i(
              "Current Location: ${position.latitude}, ${position.longitude}",
            );
            updateMyMarker(position);
            socket.emit("updateLocation", {
              "latitude": position.latitude,
              "longitude": position.longitude,
            });
          },
        );
    logger.i("Started sending location updates");
  }

  void updateMyMarker(Position position) {
    const myMarkerId = "me";

    markers.removeWhere((m) => m.markerId.value == myMarkerId);

    markers.add(
      Marker(
        markerId: const MarkerId(myMarkerId),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: "My Location"),
      ),
    );
    logger.i("Marker value: $markers");
    markers.refresh(); // ✅ important
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        16,
      ),
    );
  }

  void fetchFriendLocation() async {
    try {
      final token = await StorageService.getData("token");
      final friendLocationBody = await ApiService.get(
        ApiEndpoints.getFriendsLocation,
        token,
      );
      logger.i("Friend Location: $friendLocationBody");

      for (var user in friendLocationBody["data"]) {
        updateMarker(user);
      }
    } catch (e) {
      logger.e("Error fetching friend location: ${e.toString()}");
    }
  }

  void listenRealTimeFriendLocationUpdates() {
    socket.on("friendLocationUpdate", (data) {
      logger.i("Received location update: $data");
      updateMarker(data);
    });
  }

  void stopSendingLocation() {
    locationStream?.cancel();
  }

  @override
  void onClose() {
    socket.disconnect();
    stopSendingLocation();
    super.onClose();
  }
}

//new code
// import 'dart:async';

// import 'package:chat_backend/app/services/api_endpoints.dart';
// import 'package:chat_backend/app/services/api_service.dart';
// import 'package:chat_backend/app/services/location_permission.dart';
// import 'package:chat_backend/app/services/storage_service.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:logger/logger.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class LocationScreenController extends GetxController {
//   final logger = Logger();

//   late IO.Socket socket;
//   StreamSubscription<Position>? locationStream;

//   final RxSet<Marker> markers = <Marker>{}.obs;

//   GoogleMapController? mapController;

//   // ------------------------------------------------------------
//   // INIT
//   // ------------------------------------------------------------
//   @override
//   void onInit() {
//     super.onInit();
//     initLocationSystem();
//   }

//   Future<void> initLocationSystem() async {
//     try {
//       await LocationPermissionService.requestLocationPermission();
//       await initializeSocket();
//     } catch (e) {
//       logger.e("❌ Error initializing location system: $e");
//     }
//   }

//   // ------------------------------------------------------------
//   // SOCKET INITIALIZATION
//   // ------------------------------------------------------------
//   Future<void> initializeSocket() async {
//     final token = await StorageService.getData("token");

//     if (token == null) {
//       logger.e("❌ Token not found, socket not connecting");
//       return;
//     }

//     socket = IO.io(
//       "http://192.168.1.4:3000",
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .setAuth({"token": token})
//           .build(),
//     );

//     socket.connect();

//     socket.onConnect((_) {
//       logger.i("✅ Socket Connected Successfully");

//       // Start everything AFTER socket connects
//       fetchFriendLocations();
//       listenRealTimeFriendUpdates();
//       startSendingMyLocation();
//     });

//     socket.onDisconnect((_) {
//       logger.w("⚠️ Socket Disconnected");
//     });
//   }

//   // ------------------------------------------------------------
//   // MY LOCATION STREAM + MARKER
//   // ------------------------------------------------------------
//   void startSendingMyLocation() {
//     locationStream?.cancel(); // prevent duplicate streams

//     locationStream = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 20,
//       ),
//     ).listen((position) {
//       logger.i("📍 My Location: ${position.latitude}, ${position.longitude}");

//       // Show my marker
//       updateMyMarker(position);

//       // Send to backend
//       socket.emit("updateLocation", {
//         "latitude": position.latitude,
//         "longitude": position.longitude,
//       });
//     });

//     logger.i("✅ Started sending location updates");
//   }

//   void updateMyMarker(Position position) {
//     const myMarkerId = "me";

//     markers.removeWhere((m) => m.markerId.value == myMarkerId);

//     markers.add(
//       Marker(
//         markerId: const MarkerId(myMarkerId),
//         position: LatLng(position.latitude, position.longitude),
//         infoWindow: const InfoWindow(title: "My Location"),
//       ),
//     );

//     markers.refresh();

//     // Move camera to my location
//     mapController?.animateCamera(
//       CameraUpdate.newLatLng(
//         LatLng(position.latitude, position.longitude),
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // FRIEND MARKERS (API + SOCKET)
//   // ------------------------------------------------------------
//   void updateFriendMarker(dynamic data) {
//     final userId = data["user"] is Map
//         ? data["user"]["_id"]
//         : data["user"];

//     final latitude = data["latitude"];
//     final longitude = data["longitude"];

//     markers.removeWhere((m) => m.markerId.value == userId);

//     markers.add(
//       Marker(
//         markerId: MarkerId(userId),
//         position: LatLng(latitude, longitude),
//         infoWindow: const InfoWindow(title: "Friend"),
//       ),
//     );

//     markers.refresh();

//     logger.i("✅ Friend Marker Updated: $userId");
//   }

//   // ------------------------------------------------------------
//   // FETCH FRIEND LOCATIONS (API)
//   // ------------------------------------------------------------
//   Future<void> fetchFriendLocations() async {
//     try {
//       final token = await StorageService.getData("token");

//       final response = await ApiService.get(
//         ApiEndpoints.getFriendsLocation,
//         token,
//       );

//       logger.i("🌍 Friend Location Response: $response");

//       if (response == null || response["data"] == null) return;

//       for (var friend in response["data"]) {
//         updateFriendMarker(friend);
//       }
//     } catch (e) {
//       logger.e("❌ Error fetching friend locations: $e");
//     }
//   }

//   // ------------------------------------------------------------
//   // REAL-TIME FRIEND UPDATES (SOCKET)
//   // ------------------------------------------------------------
//   void listenRealTimeFriendUpdates() {
//     socket.on("friendLocationUpdate", (data) {
//       logger.i("📡 Friend Location Update Received: $data");
//       updateFriendMarker(data);
//     });
//   }

//   // ------------------------------------------------------------
//   // CLEANUP
//   // ------------------------------------------------------------
//   @override
//   void onClose() {
//     socket.disconnect();
//     locationStream?.cancel();
//     super.onClose();
//   }
// }
