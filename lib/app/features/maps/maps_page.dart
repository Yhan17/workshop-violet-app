import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/components/bottom_bar_component.dart';

class MapsPage extends HookWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    return Scaffold(
      body: Stack(
        children: const [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: kGooglePlex,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBarComponent(selectedPage: 2),
          ),
        ],
      ),
    );
  }
}
