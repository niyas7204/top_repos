import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_git/controllers/get_repo_data_controller.dart';
import 'package:top_git/core/helpers/enums.dart';
import 'package:top_git/view/components/repo_tile.dart';
import 'package:top_git/view/utils/styled_texts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 240, 240),
        body: Consumer(builder: (context, ref, child) {
          final getRepo = ref.read(getRepoNotifier.notifier);

          final repoNotifier = ref.watch(getRepoNotifier);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (repoNotifier.status!.status == StateStatus.initial) {
              await getRepo.getRepo(pagination: false);
            }
          });

          return SafeArea(
              child: RefreshIndicator(
            onRefresh: () {
              return getRepo.getRepo(pagination: false);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledTexts.header25("Top Starred Repos"),
                    // To Show error message when call fails
                    repoNotifier.status!.status == StateStatus.error
                        ? Center(
                            child: StyledTexts.erroText(
                                repoNotifier.status!.errorMessage!),
                          )
                        : const SizedBox(),
                    repoNotifier.wholeRepos != null &&
                            repoNotifier.wholeRepos!.repos.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) => RepoTile(
                                item: repoNotifier.wholeRepos!.repos[index],
                                errorMessage:
                                    repoNotifier.status!.errorMessage),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,
                                ),
                            itemCount: repoNotifier.wholeRepos!.repos.length)
                        : const SizedBox(),
                    //To Show laoding indicater when call trigers
                    repoNotifier.status!.status == StateStatus.loading
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox(),
                    // Button to load more data(pagination)
                    repoNotifier.status!.status == StateStatus.success
                        ? Center(
                            child: TextButton(
                                onPressed: () {
                                  getRepo.getRepo(pagination: true);
                                },
                                child: const Text(
                                  "Load More",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                )),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ));
        }));
  }
}
