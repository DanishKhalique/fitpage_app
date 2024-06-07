import 'package:flutter/material.dart';
import 'package:travel_diary_flutter/feature/models/scan_model.dart';
import 'package:travel_diary_flutter/feature/ui/variable_details_screen.dart';

class ScanCriteriaWidget extends StatelessWidget {
  final Scan scan;

  const ScanCriteriaWidget({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(scan.name)),
      body: Column(
        children: [
          ListTile(
            title: Text(scan.name),
            subtitle: Text(scan.tag),
            tileColor:
                scan.color == 'green' ? Colors.green[100] : Colors.red[100],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scan.criteria.length,
              itemBuilder: (context, index) {
                final Criteria criteria = scan.criteria[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(children: criteria.getFormattedText(context)),
                      ),
                      index < scan.criteria.length - 1
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("&"),
                            )
                          : const Offstage()
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(14),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension CriteriaExtension on Criteria {
  List<InlineSpan> getFormattedText(BuildContext context) {
    List<InlineSpan> spans = [];
    String formattedText = text;
    if (variable != null) {
      variable!.forEach((key, variable) {
        print(key);

        // print(variable.toString());

        var variableIndex = formattedText.indexOf(key);
        print(variableIndex);
        print(formattedText.substring(0, variableIndex));
        spans.add(TextSpan(
          text: formattedText.substring(0, variableIndex),
        ));
        spans.add(WidgetSpan(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VariableDetailsScreen(
                    keyValue: key,
                    variable: variable,
                  ),
                ),
              );
            },
            child: Text(
              variable is ValueVariable
                  ? '(${variable.values.first.toString()})'
                  : '(${variable.defaultValue.toString()})',
              style: const TextStyle(
                color: Color.fromARGB(255, 131, 85, 248),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ));
        formattedText = formattedText.substring(variableIndex + key.length);
      });
    }
    spans.add(TextSpan(text: formattedText));
    return spans;
  }
}
