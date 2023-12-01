import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_git/controllers/get_repo_data_controller.dart';
import 'package:top_git/core/helpers/enums.dart';
import 'package:top_git/database/database_handler.dart';
import 'package:top_git/view/components/repo_tile.dart';
import 'package:top_git/view/utils/styled_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 240, 240),
        body: Consumer(
          builder: (context, ref, child) {
            final getRepo = ref.read(getRepoNotifier.notifier);

            final repoNotifier = ref.watch(getRepoNotifier);
            log(repoNotifier.status.toString());

            switch (repoNotifier.status) {
              case StateStatus.success:
                return SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledTexts.header1("Top Starred Repos"),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) => RepoTile(
                                  item: repoNotifier.data!.repos[index],
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,
                                ),
                            itemCount: repoNotifier.data!.repos.length),
                        ElevatedButton(
                            onPressed: () {
                              getRepo.getRepo();
                            },
                            child: const Text(
                              'click',
                              style: TextStyle(fontSize: 50),
                            )),
                        ElevatedButton(
                            onPressed: () async {
                              final db =
                                  await DataBaseHandler.instance.getAllData();
                              log(db.repos.length.toString());
                            },
                            child: const Text(
                              'db ',
                              style: TextStyle(fontSize: 50),
                            )),
                        ElevatedButton(
                            onPressed: () async {
                              await DataBaseHandler.instance.delete();
                            },
                            child: const Text(
                              'delete ',
                              style: TextStyle(fontSize: 50),
                            )),
                      ],
                    ),
                  ),
                ));
              case StateStatus.error:
                return Center(
                  child: StyledTexts.header25(repoNotifier.errorMessage!),
                );
              case StateStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              default:
                return Center(
                  child: ElevatedButton(
                      onPressed: () {
                        getRepo.getRepo();
                      },
                      child: const Text(
                        'click',
                        style: TextStyle(fontSize: 50),
                      )),
                );
            }
          },
        ));
  }
}
