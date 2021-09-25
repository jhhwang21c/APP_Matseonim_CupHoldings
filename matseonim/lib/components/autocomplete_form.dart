import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteForm extends StatelessWidget {
  final String hintText;
  final TextEditingController? textController;

  const AutocompleteForm({required this.hintText, this.textController});

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: textController,
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ))),
      suggestionsCallback: (pattern) {
        return Professions.getSuggestions(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (String suggestion) {
        textController?.text = suggestion;
      },
    );
  }
}

class Professions {
  static final List<String> profession = [
    '농구',
    '축구',
    '배드민턴',
    '영어',
    '코딩',
    '제초',
    '미용',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(profession);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
