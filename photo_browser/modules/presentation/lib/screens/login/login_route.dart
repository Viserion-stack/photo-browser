import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/injector_container.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/login_argument.dart';
import 'package:presentation/screens/login/login_screen.dart';

Widget loginRoute(GoRouterState state) => MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => injector<LoginBloc>(
            param1: state.extra ?? const LoginArgument(),
          )..add(const LoginEvent.onInitiated()),
        ),
      ],
      child: LoginScreen(),
    );
