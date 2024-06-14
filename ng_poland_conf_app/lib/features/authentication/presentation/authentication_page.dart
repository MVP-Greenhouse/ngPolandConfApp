import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/sign_in_social_media_type.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/widgets/social_media_button.dart';
import 'package:ng_poland_conf_app/injectable.dart';

class AuthenticationPage extends StatefulWidget {
  static const String path = '/auth';

  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final AuthenticationCubit authenticationCubit;

  @override
  void initState() {
    authenticationCubit = getIt.get<AuthenticationCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => authenticationCubit,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_blured.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return IgnorePointer(
                  ignoring: state.maybeWhen(
                    inProgress: (_) => true,
                    orElse: () => false,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ngpolandlogo.png',
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 96,
                        ),
                        SocialMediaButton(
                          isLoading: state.maybeMap(
                            inProgress: (value) => value.type == AuthenticationType.google,
                            orElse: () => false,
                          ),
                          onTap: () => authenticationCubit.signInSocialMedia(SignInGoogle()),
                          authenticationType: AuthenticationType.google,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        if (Platform.isIOS)
                          SocialMediaButton(
                            isLoading: state.maybeMap(
                              inProgress: (value) => value.type == AuthenticationType.apple,
                              orElse: () => false,
                            ),
                            onTap: () => authenticationCubit.signInSocialMedia(SignInApple()),
                            authenticationType: AuthenticationType.apple,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
