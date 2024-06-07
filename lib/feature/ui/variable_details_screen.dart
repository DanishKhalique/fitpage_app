import 'package:flutter/material.dart';
import 'package:travel_diary_flutter/feature/models/scan_model.dart';

class VariableDetailsScreen extends StatelessWidget {
  final String keyValue;
  final dynamic variable;

  const VariableDetailsScreen(
      {super.key, required this.keyValue, required this.variable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Variable Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: variable is ValueVariable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  ...variable.values.map<Widget>((value) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(value.toString()),
                          const Divider(
                            indent: 2,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ],
              )
            : variable is IndicatorVariable
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        variable.studyType.toString().toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Set parameters",
                      ),
                      Container(
                        color: const Color.fromARGB(255, 249, 253, 226),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(variable.parameterName
                                      .toString()
                                      .toUpperCase())),
                              Expanded(
                                  child: TextField(
                                style: const TextStyle(color: Colors.black),
                                controller: TextEditingController(
                                    text: variable.defaultValue.toString()),
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
      ),
    );
  }
}
