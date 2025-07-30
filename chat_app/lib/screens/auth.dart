import 'dart:io';

import 'package:chat_app/auth_providers.dart';
import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  // Changed to ConsumerState
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  // var _isAuthenticating = false; // Replaced by watching the provider's state

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    // Specific check for image during signup
    if (!_isLogin && _selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick an image for your account.')),
      );
      return;
    }

    _formKey.currentState!.save();

    // Call the notifier methods
    if (_isLogin) {
      ref
          .read(authNotifierProvider.notifier)
          .signInWithEmailAndPassword(_enteredEmail, _enteredPassword);
    } else {
      ref
          .read(authNotifierProvider.notifier)
          .signUpWithEmailAndPassword(
            _enteredEmail,
            _enteredPassword,
            _selectedImage, // Pass the image here
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsyncValue = ref.watch(authNotifierProvider);
    final isLoading = authAsyncValue is AsyncLoading;

    // Listen to the provider for side-effects like showing SnackBars
    ref.listen<AsyncValue<AuthScreenState>>(authNotifierProvider, (_, state) {
      state.whenOrNull(
        data: (authState) {
          // This is when AsyncData is emitted by the notifier
          if (authState.status == AuthStatus.error &&
              authState.errorMessage != null) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(authState.errorMessage!)));
          }
          // Successful authentication will trigger navigation via authStateChangesProvider
        },
        error: (error, stackTrace) {
          // This handles errors from the AsyncNotifier itself (e.g., during build)
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ), // Or a more user-friendly message
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickedImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 7) {
                                return 'Password must be at least 7 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (isLoading) const CircularProgressIndicator(),
                          if (!isLoading)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                              onPressed: _submit,
                              child: Text(_isLogin ? "Login" : "Signup"),
                            ),
                          if (!isLoading)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? "Create an account"
                                    : "I already have an account. Login.",
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
