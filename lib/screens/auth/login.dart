import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/auth_state.dart';
import 'package:zoo_connect_app/models/auth/validators.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Timer? _debounce;
  bool _obscureTextPass = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmailWithDebounce);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmailWithDebounce);
    _emailController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _validateEmailWithDebounce() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      next.whenOrNull(
        autenticado: (_, __, ___) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '¡Bienvenido!',
                style: TextStyle(color: colors.onPrimaryContainer),
              ),
              backgroundColor: colors.primaryContainer,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: colors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

    final isLoading = authState.maybeWhen(
      cargando: () => true,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('ZooConnect'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "¡Bienvenido de nuevo!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(75),
                            ),
                            child: Container(
                              color: colors.primary.withAlpha(25),
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/logos/logo-claro.png'),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Correo Electronico",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            validator: FormValidators.validateEmail,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: "Contraseña",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextPass = !_obscureTextPass;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscureTextPass,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        final email = _emailController.text;
                                        final password =
                                            _passwordController.text;
                                        ref
                                            .read(authProvider.notifier)
                                            .login(email, password);
                                      }
                                    },
                              child: isLoading
                                  ? CustomLoader(size: 60)
                                  : const Text("Iniciar Sesión"),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "¿Olvidaste tu contraseña?",
                              style: TextStyle(
                                color: colors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿No tienes una cuenta?"),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        "Registrate",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
