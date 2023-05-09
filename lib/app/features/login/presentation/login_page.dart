import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../core/http/backend_http_client.dart';
import '../../../core/infra/repositories/user_repository_impl.dart';
import '../infra/usecases/login_usecase_impl.dart';
import 'controllers/login_controller.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/app_images.dart';
import '../../../shared/widgets/violet_text_input_widget.dart';

import '../../../shared/widgets/violet_button_widget.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(text: '');
    final user = useState<String>('');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;

    final loginController = LoginController(
      LoginUsecaseImpl(
        repository: UserRepositoryImpl(
          client: BackendHttpClient(),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight / 2,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(140),
                            bottomRight: Radius.circular(140),
                          ),
                          child: Container(
                            color: AppColors.background,
                            height: screenHeight / 3,
                            width: screenWidth,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 1,
                          left: 1,
                          child: Hero(
                            tag: 'logo',
                            child: Image.asset(
                              AppImages.logo,
                              height: 200,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    'Violet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'O seu app de monitoramento físico',
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: VioletTextInputWidget(
                      text: 'usuário',
                      controller: controller,
                      onChanged: (value) {
                        user.value = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: VioletButtonWidget(
                            isLoading: loginController.state.maybeWhen(
                              loadInProgress: () => true,
                              orElse: () => false,
                            ),
                            onPressed: () async {
                              if (user.value.isNotEmpty) {
                                await loginController.login(
                                  user.value,
                                  context,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Erro ao tentar obter o usuario'),
                                  ),
                                );
                              }

                              if (loginController.state.maybeWhen(
                                  loadSuccess: (_) => true,
                                  orElse: () => false)) {
                                // ignore: use_build_context_synchronously
                                GoRouter.of(context).pushReplacement('/home');
                              }
                            },
                            text: 'entrar',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
