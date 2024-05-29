import 'package:flutter/material.dart';
import 'package:flutter_ads/src/features/ads/cubit/ads_cubit.dart';
import 'package:flutter_ads/src/features/ads/model/interests.dart';
import 'package:flutter_ads/src/features/ads/states/ads_states.dart';
import 'package:flutter_ads/src/features/ads/usecases/delete_interest.dart';
import 'package:flutter_ads/src/features/ads/usecases/do_signout.dart';
import 'package:flutter_ads/src/features/ads/ui/ad_sense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AdsCubit>().getUserData();
    });
  }

  Map<String, String> convertListToTargetingOptions(
      List<Interests> interestsList) {
    Map<String, String> targetingOptions = {};

    for (var interest in interestsList) {
      targetingOptions[interest.interest] = interest.interest;
    }

    return targetingOptions;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AdsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Ads'),
        actions: [
          IconButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await context.read<DoSignOut>().signOut();
                navigator.pushReplacementNamed('/');
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is LoadingUserData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LoadedUserDataAdsState) {
                if (state.userData == null) {
                  return const Text("Dados dos usuario nulos");
                }

                return ListView(
                  children: [
                    Text("ID: ${state.userData!.user!.uid}"),
                    Text("Nome: ${state.userData!.user!.displayName}"),
                    Text("E-mail: ${state.userData!.user!.email}"),
                    const SizedBox(height: 15),
                    const Text("Interesses:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                        height:
                            8), // Espaçamento entre o título dos interesses e a lista de interesses
                    state.userData!.interests != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.userData!.interests!.map((entry) {
                              return ListTile(
                                leading: Text(entry.interest),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await context
                                        .read<DeleteInterest>()
                                        .deleteInterest(entry.id);

                                    html.window.location.reload();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : const SizedBox(),
                    Center(
                      child: AdSenseWidget(
                        adSlot: 'sdsdsdsd',
                        adFormat: 'auto',
                        adClient: 'sdsds',
                        targetingOptions: convertListToTargetingOptions(
                            state.userData!.interests!),
                      ),
                    )
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addInterest');
          html.window.location.reload();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
