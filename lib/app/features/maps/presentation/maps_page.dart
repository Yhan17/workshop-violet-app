import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/config/env.dart';
import '../../../core/http/backend_http_client.dart';
import '../../../core/infra/repositories/user_repository_impl.dart';
import '../../../shared/components/bottom_bar_component.dart';
import '../infra/usecases/users_usecase_impl.dart';
import 'controller/user_controller.dart';

class MapsPage extends HookWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markers = useState<List<Marker>>([]);
    const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(
        -10.203680,
        -48.334929,
      ),
      zoom: 14.4746,
    );

    final userController = UsersController(
      UsersUsecaseImpl(
        repository: UserRepositoryImpl(
          client: BackendHttpClient(),
        ),
      ),
    );

    IO.Socket socket = IO.io('${Env.backendUrl}/user/index');

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        socket.onConnect((_) {
          debugPrint('connected Socket');
        });
        socket.onConnecting((_) {
          debugPrint('connecting');
        });
        socket.onError((e) {
          debugPrint('Socket: $e');
        });
        socket.connect();
        socket.on(
          'user-action',
          (_) async {
            final result = await userController.fetchUsers(context);
            markers.value = result
                .getOrElse(() => [])
                .map(
                  (marker) => Marker(
                    markerId: MarkerId(
                      '${marker.name}-${marker.id}',
                    ),
                    position: marker.latitude != null
                        ? LatLng(
                            double.tryParse(marker.latitude!) ?? 0,
                            double.tryParse(marker.longitude!) ?? 0,
                          )
                        : const LatLng(0, 0),
                  ),
                )
                .toList();
          },
        );
      });
      return () => socket.disconnect();
    }, const []);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: kGooglePlex,
            markers: markers.value.toSet(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomBarComponent(selectedPage: 2),
          ),
        ],
      ),
    );
  }
}
