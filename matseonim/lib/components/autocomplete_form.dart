import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutocompleteForm extends StatelessWidget {
  final String hintText;
  final TextEditingController? textController;
  final String? flag;

  const AutocompleteForm({required this.hintText, this.textController, this.flag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TypeAheadFormField(
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
            )
          )
        ),
        suggestionsCallback: (pattern) {
          if (flag == 'BaseName'){
          return BaseName.getSuggestions(pattern);
          }else{
          return Professions.getSuggestions(pattern);
          }
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
      )
    );
  }
}

class Professions {

  static final List<String> profession = [
    '사격',
    '총기손질',
    '화생방',
    '풋살',
    '농구',
    '축구',
    '배드민턴',
    '영어',
    '일본어',
    '중국어',
    '수능',
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

class BaseName {

  static final List<String> basename = [
    '제20전투비행단', '제10전투비행단', '제15특수임무비행단', '제3훈련비행단', '제5공중기동비행단', 
    '제11전투비행단', '제16전투비행단', '제1전투비행단', '제38전투비행전대',
    '제17전투비행단', '제19전투비행단', '제8전투비행단', '제18전투비행단'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(basename);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}