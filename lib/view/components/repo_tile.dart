import 'package:flutter/material.dart';
import 'package:top_git/core/constants/spaces.dart';
import 'package:top_git/model/repo_database_model.dart';
import 'package:top_git/view/utils/styled_texts.dart';

class RepoTile extends StatelessWidget {
  final DatabaseModel item;
  final String? errorMessage;
  const RepoTile({super.key, required this.item, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledTexts.labelText("User :${item.user}"),
                  StyledTexts.labelText(item.fullName),
                  item.description != null
                      ? StyledTexts.nameText(item.description!)
                      : const SizedBox(),
                  StyledTexts.text15("${item.stargazersCount} Stars")
                ],
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(item.avatarurl),
              child: errorMessage != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMessage!,
                        style:
                            TextStyle(color: Color.fromARGB(172, 244, 67, 54)),
                      ),
                    )
                  : const SizedBox(),
            ),
            SpaceSized.space10w,
          ],
        ),
      ),
    );
  }
}
