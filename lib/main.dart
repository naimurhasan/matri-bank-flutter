import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/bloc/domain/account_details/account_details_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/home_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/splash_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<AccountDetailsBloc>(
          create: (BuildContext context) => AccountDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
