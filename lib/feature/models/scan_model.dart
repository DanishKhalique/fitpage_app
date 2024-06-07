class Scan {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<Criteria> criteria;

  Scan({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  factory Scan.fromJson(Map<String, dynamic> json) {
    var criteriaList = json['criteria'] as List;
    List<Criteria> criteria =
        criteriaList.map((i) => Criteria.fromJson(i)).toList();

    return Scan(
      id: json['id'],
      name: json['name'],
      tag: json['tag'],
      color: json['color'],
      criteria: criteria,
    );
  }
}

class Criteria {
  final String type;
  final String text;
  final Map<String, dynamic>? variable;

  Criteria({
    required this.type,
    required this.text,
    this.variable,
  });

  factory Criteria.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? variable;

    if (json['variable'] != null) {
      variable = {};
      json['variable'].forEach((key, value) {
        if (value['type'] == 'value') {
          variable![key] = ValueVariable.fromJson(value);
        } else if (value['type'] == 'indicator') {
          variable![key] = IndicatorVariable.fromJson(value);
        } else {
          throw Exception('Unknown variable type');
        }
      });
    }

    return Criteria(
      type: json['type'],
      text: json['text'],
      variable: variable,
    );
  }

  // String getFormattedText() {
  //   var formattedText = text;
  //   variable?.forEach((key, variable) {
  //     if (variable is ValueVariable && variable.values.isNotEmpty) {
  //       formattedText =
  //           formattedText.replaceAll(key, variable.values.first.toString());
  //     } else if (variable is IndicatorVariable) {
  //       formattedText =
  //           formattedText.replaceAll(key, variable.defaultValue.toString());
  //     }
  //   });
  //   return formattedText;
  // }
}

class ValueVariable {
  final String type;
  final List<dynamic> values;

  ValueVariable({
    required this.type,
    required this.values,
  });

  factory ValueVariable.fromJson(Map<String, dynamic> json) {
    return ValueVariable(
      type: json['type'],
      values: List<dynamic>.from(json['values']),
    );
  }
}

class IndicatorVariable {
  final String type;
  final String studyType;
  final String parameterName;
  final int minValue;
  final int maxValue;
  final int defaultValue;

  IndicatorVariable({
    required this.type,
    required this.studyType,
    required this.parameterName,
    required this.minValue,
    required this.maxValue,
    required this.defaultValue,
  });

  factory IndicatorVariable.fromJson(Map<String, dynamic> json) {
    return IndicatorVariable(
      type: json['type'],
      studyType: json['study_type'],
      parameterName: json['parameter_name'],
      minValue: json['min_value'],
      maxValue: json['max_value'],
      defaultValue: json['default_value'],
    );
  }
}
