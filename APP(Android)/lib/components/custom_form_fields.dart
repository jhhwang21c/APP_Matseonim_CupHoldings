import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import 'package:matseonim/utils/validator.dart';

enum AutocompleteFormFlag {
  baseNames,
  professions
}

class BaseNames {
  static final List<String> baseNames = [
    '제1전투비행단',
    '제8전투비행단',
    '제10전투비행단', 
    '제11전투비행단', 
    '제16전투비행단',
    '제17전투비행단', 
    '제18전투비행단',
    '제19전투비행단',
    '제20전투비행단',
    '제3훈련비행단', 
    '제5공중기동비행단',
    '제15특수임무비행단',
    '제39특수임무비행단',
    '제1방공유도탄여단',
    '제2방공유도탄여단',
    '제3방공유도탄여단',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];

    matches.addAll(baseNames);
    matches.retainWhere(
      (s) => s.toLowerCase().contains(query.toLowerCase())
    );
    
    return matches;
  }
}

class Professions {
  static final List<String> professions = [
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

    matches.addAll(professions);
    matches.retainWhere(
      (s) => s.toLowerCase().contains(query.toLowerCase())
    );
  
    return matches;
  }
}

class AutocompleteForm extends StatelessWidget {
  final String hintText;

  final TextEditingController? textController;
  final AutocompleteFormFlag? formFlag;

  const AutocompleteForm({
    Key? key,
    required this.hintText, 
    this.formFlag,
    this.textController, 
  }) : super(key: key);

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
          if (formFlag == AutocompleteFormFlag.baseNames) {
            return BaseNames.getSuggestions(pattern);
          } else {
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

class MultilineFormField extends StatelessWidget {
  final String? hintText;
  final Validator? funValidator;

  final TextEditingController textController;

  const MultilineFormField({
    Key? key,
    required this.textController,
    this.hintText,
    this.funValidator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      maxLines: 20,
      controller: textController,
      validator: funValidator,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText ?? "내용을 입력하세요",
        hintStyle: TextStyle(fontSize: 16),
        filled: true,
        fillColor: Colors.white,
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
    );
  }
}

class ObscurableFormFieldController extends GetxController {
  bool obscureText = true;
  bool shouldObscure = false;

  ObscurableFormFieldController(this.shouldObscure);

  void toggleObscureText() {
    if (shouldObscure) {
      obscureText = !obscureText;
      update();
    }
  }
}

class ObscurableFormField extends GetView<ObscurableFormFieldController> {
  final bool shouldObscure;

  final String? hintText;
  final Validator? funValidator;
  final TextEditingController? textController;

  const ObscurableFormField({
    Key? key,
    required this.shouldObscure,
    this.hintText,
    this.funValidator,
    this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GetBuilder<ObscurableFormFieldController>(
        global: false,
        init: ObscurableFormFieldController(shouldObscure),
        dispose: (_) => textController?.dispose(),
        builder: (_) => TextFormField(
          controller: textController,
          obscureText: _.shouldObscure && _.obscureText,
          validator: funValidator,
          decoration: InputDecoration(
            hintText: hintText ?? "",
            suffixIcon: _.shouldObscure ? IconButton(
              icon: Icon(
                _.obscureText
                ? Icons.visibility_off 
                : Icons.visibility,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _.toggleObscureText,
            ) : null,
            filled: true,
            fillColor: Colors.white,
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
        )
      )
    );
  }
}