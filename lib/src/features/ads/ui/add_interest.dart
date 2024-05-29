import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/ads/usecases/add_interest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInterestPage extends StatefulWidget {
  const AddInterestPage({super.key});

  @override
  State<AddInterestPage> createState() => AaddInterestStatePage();
}

class AaddInterestStatePage extends State<AddInterestPage> {
  final interestController = TextEditingController();

  @override
  void dispose() {
    interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: interestController,
              decoration: const InputDecoration(hintText: "Interesse"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (interestController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("É necessário adicionar um interesse")));
                  } else {
                    final nagigator = Navigator.of(context);

                    await context
                        .read<AddInterest>()
                        .add(interestController.text);
                    nagigator.pop();
                  }
                },
                child: const Text("Adicionar interesse em anuncio"))
          ],
        ),
      ),
    );
  }
}
