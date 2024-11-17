import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/state/file_picker_state.dart';
import 'package:babysitterapp/core/components.dart';

import 'package:babysitterapp/models/models.dart';

class DynamicForm extends HookWidget {
  DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.isLoading,
  });

  final List<InputFieldConfig> fields;
  final void Function(Map<String, String>) onSubmit;
  final ValueNotifier<bool>? isLoading;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, TextEditingController> controllers =
        useControllers(fields);
    final ValueNotifier<Map<String, String>> formData = useFormData(fields);
    final ValueNotifier<Map<String, String?>> errors = useErrors(fields);
    final ValueNotifier<bool> defaultLoading = useState(false);
    final Map<String, ValueNotifier<FilePickerState>> fileStates =
        useFileStates(fields);

    useEffect(() {
      return () {
        for (final TextEditingController controller in controllers.values) {
          controller.dispose();
        }
      };
    }, <Object?>[controllers]);

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          ...fields.map((InputFieldConfig field) => Column(
                children: <Widget>[
                  buildField(
                    field,
                    controllers,
                    formData,
                    errors,
                    isLoading ?? defaultLoading,
                    fileStates,
                  ),
                  const SizedBox(height: 16),
                ],
              )),
          buildSubmitButton(
            formKey,
            isLoading ?? defaultLoading,
            formData,
            onSubmit,
          ),
        ],
      ),
    );
  }
}
