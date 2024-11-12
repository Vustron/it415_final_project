import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

Widget buildSubmitButton(
  GlobalKey<FormState> formKey,
  ValueNotifier<bool> isLoading,
  ValueNotifier<Map<String, String>> formData,
  void Function(Map<String, String>) onSubmit,
) {
  return ValueListenableBuilder<bool>(
    valueListenable: isLoading,
    builder: (BuildContext context, bool loading, Widget? child) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: loading
              ? null
              : () async {
                  if (formKey.currentState!.validate()) {
                    isLoading.value = true;
                    onSubmit(formData.value);
                    isLoading.value = false;
                  }
                },
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: GlobalStyles.primaryButtonColor,
                    strokeWidth: 2.0,
                  ),
                )
              : const Text('Submit'),
        ),
      );
    },
  );
}
