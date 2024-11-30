import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class VerificationView extends HookConsumerWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerService);
    final UserAccount? user = authState.user;
    final ValueNotifier<bool> isLoading = useState(false);
    final Toast toastRepository = ref.watch(toastService);

    final List<InputFieldConfig> fields = <InputFieldConfig>[
      if (user?.role?.isEmpty ?? true)
        InputFieldConfig(
          label: 'Role',
          type: 'select',
          hintText: 'Select your role',
          value: user?.role,
          prefixIcon: FluentIcons.person_20_regular,
          options: const <String>['Client', 'Babysitter'],
          isRequired: true,
        ),
      InputFieldConfig(
        label: 'Valid Id Type',
        type: 'select',
        hintText: 'Select valid ID type',
        value: user?.validId,
        prefixIcon: FluentIcons.document_20_regular,
        options: const <String>[
          'National ID',
          "Driver's License",
          'Passport',
          'SSS ID',
          'PhilHealth ID',
          'Postal ID',
          "Voter's ID"
        ],
        isRequired: true,
      ),
      const InputFieldConfig(
        label: 'Valid ID Front',
        type: 'image',
        hintText: 'Upload front of valid ID',
        prefixIcon: FluentIcons.document_one_page_20_regular,
        isRequired: true,
      ),
      const InputFieldConfig(
        label: 'Valid ID Back',
        type: 'image',
        hintText: 'Upload back of valid ID',
        prefixIcon: FluentIcons.document_one_page_20_regular,
        isRequired: true,
      ),
    ];

    Future<void> onSubmit(Map<String, dynamic> data) async {
      try {
        isLoading.value = true;

        final UserAccount? updatedUser = user?.copyWith(
          role: data['Role'] as String?,
          validId: data['Valid Id Type'] as String?,
          validIdFront: data['Valid ID Front'] as String?,
          validIdBack: data['Valid ID Back'] as String?,
          validIdVerified: DateTime.now(),
        );

        if (updatedUser != null) {
          await ref
              .read(authControllerService.notifier)
              .updateUser(updatedUser);
        }

        if (context.mounted) {
          toastRepository.show(
            context: context,
            title: 'Success',
            message: 'Documents submitted successfully',
          );
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        });
      } catch (e) {
        if (context.mounted) {
          toastRepository.show(
            context: context,
            title: 'Error',
            message: e.toString(),
            type: 'error',
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Verification',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (user?.emailVerified == null) ...<Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Email Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Verify your email (${user?.email})',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await ref
                                    .read(authControllerService.notifier)
                                    .sendEmailVerification();

                                if (context.mounted) {
                                  toastRepository.show(
                                    context: context,
                                    title: 'Success',
                                    message:
                                        'Verification email sent. Please check your inbox.',
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  toastRepository.show(
                                    context: context,
                                    title: 'Error',
                                    message: e.toString(),
                                    type: 'error',
                                  );
                                }
                              }
                            },
                            child: const Text('Send Verification Email'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (fields.isNotEmpty)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Document Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        DynamicForm(
                          fields: fields,
                          onSubmit: onSubmit,
                          isLoading: isLoading,
                          userId: user?.id,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
