import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_controller.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_status.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/register/register_page.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            login: () => showLoader(),
            loginError: () {
              hideLoader();
              showError('Login ou senha inválidos!');
            },
            error: () {
              hideLoader();
              showError('Error ao realizar login!');
            },
            success: () {
              hideLoader();
              Navigator.pop(context, true);
            });
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: context.textStyles.textTitle,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'E-mail'),
                            controller: _emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail Obrigatório'),
                              Validatorless.email('E-mail inválido')
                            ])),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Senha'),
                          controller: _passwordEC,
                          validator:
                              Validatorless.required('Senha Obrigatória'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: DeliveryButton(
                            customLabel: 'ENTRAR',
                            customOnPressed: () {
                              final valid =
                                  _formKey.currentState?.validate() ?? false;
                              if (valid) {
                                controller.login(
                                  email: _emailEC.text,
                                  password: _passwordEC.text, );
                              }
                            },
                            customWidth: double.infinity,
                          ),
                        )
                      ],
                    )),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui uma conta',
                        style: context.textStyles.textBold,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RegisterPage.route);
                        },
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyles.textBold
                              .copyWith(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
