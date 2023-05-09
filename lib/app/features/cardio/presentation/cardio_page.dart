import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import '../../../core/http/backend_http_client.dart';
import '../infra/repositories/health_repository_impl.dart';
import '../infra/usecases/health_usecase_impl.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/app_animations.dart';
import '../../../shared/widgets/health_button_widget.dart';
import '../infra/usecases/latlong_usecase_impl.dart';
import 'controller/cardio_controller.dart';

class CardioPage extends HookWidget {
  const CardioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = CardioController(
      HealthUsecaseImpl(
        repository: HealthRepositoryImpl(
          client: BackendHttpClient(),
        ),
      ),
      LatLongUseCaseImpl(
        repository: HealthRepositoryImpl(
          client: BackendHttpClient(),
        ),
      ),
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchInfos();
      });
      return () => controller.cancelTimer();
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(
              top: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Violet',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                const Icon(
                  Icons.notifications,
                  color: AppColors.white,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: Container(
              height: screenHeight,
              color: AppColors.primary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        HealthButtonWidget(
                          text: '🚴🏻',
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Atividade',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Ciclismo',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        color: AppColors.white,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Text(
                              'Batimentos Cardíacos',
                              style: TextStyle(
                                color: AppColors.background,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            LottieBuilder.asset(
                              AppAnimations.heartBeatAnimation,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    text: '❤️ ',
                                    children: [
                                      TextSpan(
                                        text: 'Batimento cardíaco',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: controller.heartRate,
                                  builder: (_, dynamic value, __) {
                                    return Text(
                                      '$value/120',
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    text: '💨 ',
                                    children: [
                                      TextSpan(
                                        text: 'Oxigênio',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: controller.bloodOxygen,
                                  builder: (_, dynamic value, __) {
                                    return Text(
                                      '$value',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}