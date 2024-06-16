import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/models/oopt.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key, required this.oopts});

  final List<Oopt> oopts;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            hintText: 'Южно-камчатский природный парк',
            hintStyle: MaterialStatePropertyAll(Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorName.textHint)),
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor:
                const MaterialStatePropertyAll(ColorName.cardBackground),
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            trailing: [Assets.icons.search.svg()],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          List<ListTile> suggestions = [];
          for (var oopt in widget.oopts) {
            String name = '${oopt.name} природный парк';
            suggestions.add(ListTile(
              title: Text(name),
              onTap: () {
                setState(
                  () {
                    controller.closeView(name);
                  },
                );
              },
            ));
          }
          for (int i = 0; i < widget.oopts.length; ++i) {
            for (var trail in widget.oopts[i].trails) {
              String name = trail.name;
              suggestions.add(ListTile(
                title: Text(name),
                onTap: () {
                  setState(
                    () {
                      controller.closeView(name);
                    },
                  );
                },
              ));
            }
          }
          return suggestions;
        },
      ),
    );
  }
}
