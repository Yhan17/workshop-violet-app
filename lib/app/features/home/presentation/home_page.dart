import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'controllers/home_controller.dart';

import '../../../shared/components/bottom_bar_component.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/app_images.dart';
import '../../../shared/widgets/health_button_widget.dart';
import '../../../shared/widgets/personal_icon_widget.dart';
import '../../../shared/widgets/violet_button_widget.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HomeController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.requestPermissions();
      });
    }, const []);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Violet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    AppImages.logo,
                    height: 96,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Contrate um personal trainer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(AppImages.personal),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: const Text(
                          'Joana Malha rindo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                HealthButtonWidget(
                  text: '❤️',
                  onTap: () {
                    GoRouter.of(context).push('/cardio');
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                HealthButtonWidget(
                  text: '🚴🏻',
                  onTap: () {
                    GoRouter.of(context).push('/cardio');
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: VioletButtonWidget(
                    color: AppColors.background,
                    onPressed: () {
                      GoRouter.of(context).push('/cardio');
                    },
                    text: 'Selecionar',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Programa da Joana',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const PersonalIconWidget(
                  text: '🎤',
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Standup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('irônico não?'),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                )
              ],
            ),
            const SizedBox(
              width: 48,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarComponent(selectedPage: 1),
    );
  }
}
