import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/auth_state.dart';
import 'package:zoo_connect_app/models/auth/validators.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureTextPass = true;
  bool _obscureTextConfirmPass = true;

  Timer? _emailDebounce;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmailWithDebounce);
    _nameController.addListener(_validateInstant);
    _passwordController.addListener(_validateInstant);
    _confirmPasswordController.addListener(_validateInstant);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmailWithDebounce);
    _nameController.removeListener(_validateInstant);
    _passwordController.removeListener(_validateInstant);
    _confirmPasswordController.removeListener(_validateInstant);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailDebounce?.cancel();
    super.dispose();
  }

  void _validateEmailWithDebounce() {
    if (_emailDebounce?.isActive ?? false) {
      _emailDebounce!.cancel();
    }
    _emailDebounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        _formKey.currentState?.validate();
      }
    });
  }

  void _validateInstant() {
    if (mounted) {
      _formKey.currentState?.validate();
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authProvider.notifier);
      final email = _emailController.text;
      final username = _nameController.text;
      final password = _passwordController.text;

      await authNotifier.register(email, username, password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cuenta creada exitosamente!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, corrige los errores del formulario.'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      next.whenOrNull(
        autenticado: (usuario, accessToken, refreshToken) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Registro exitoso! Redireccionando...'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          // Navigator.pushReplacementNamed(context, '/home');
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $message'),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                            "Crea tu cuenta",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("¡Unete a la aventura!"),
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
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Nombre",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            validator: FormValidators.validateName,
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
                            validator: (value) =>
                                FormValidators.validateEmail(value),
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
                            validator: FormValidators.validatePassword,
                            obscureText: _obscureTextPass,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: "Confirmar contraseña",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextConfirmPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextConfirmPass =
                                        !_obscureTextConfirmPass;
                                  });
                                },
                              ),
                            ),
                            validator: (value) =>
                                FormValidators.validatePasswordMatch(
                                  value ?? '',
                                  _passwordController.text,
                                ),
                            obscureText: _obscureTextConfirmPass,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: isLoading ? null : _submitForm,
                              child: isLoading
                                  ? CustomLoader(size: 60)
                                  : const Text("Crear Cuenta"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Ya tienes una cuenta?"),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      child: Text(
                        "Iniciar Sesión",
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
