import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/auth/login/cubit/login_cubit.dart';
import 'package:flutter_ads/src/features/auth/login/models/logged_user.dart';
import 'package:flutter_ads/src/features/auth/login/states/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  resumeLoginScreen() {
    Navigator.of(context).pushReplacementNamed('/ads');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoggedUser) {
          html.window.location.reload();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            Widget body = const SizedBox();

            if (state is InitialLoginState) {
              body = Container(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "E-mail"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Senha"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                            emailController.text, passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width, 50)),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(child: Text("Não tem conta?")),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width, 50)),
                      child: const Text(
                        "Criar conta",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LoadingLoginState) {
              body = const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorLogginState) {
              body = Column(
                children: [
                  Text(state.errorMessage),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        html.window.location.reload();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width, 50)),
                      child: const Text(
                        "Tentar novamente",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              );
            }

            if (state is LoggedState) {
              html.window.location.reload();
            }

            return body;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
