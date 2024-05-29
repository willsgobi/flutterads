import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/auth/register/cubit/register_cubit.dart';
import 'package:flutter_ads/src/features/auth/register/states/register_states.dart';
import 'dart:html' as html;
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RegisterCubit>();
    final state = cubit.state;

    Widget body = const SizedBox();

    if (state is InitialRegisterState) {
      body = Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Nome"),
            ),
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
                cubit.registerUser(nameController.text, emailController.text,
                    passwordController.text);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(MediaQuery.sizeOf(context).width, 50)),
              child: const Text(
                "Registrar",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }

    if (state is LoadingRegisterState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorRegisterState) {
      body = Column(
        children: [
          Text(state.errorMessage),
          ElevatedButton(
              onPressed: () {
                html.window.location.reload();
              },
              child: const Text("Tentar novamente"))
        ],
      );
    }

    if (state is SuccessRegisterState) {
      html.window.location.reload();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
      ),
      body: body,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
