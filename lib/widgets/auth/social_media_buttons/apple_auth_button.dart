import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '/../blocs/auth/auth_bloc.dart';
import '/../blocs/auth/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppleAuthButton extends StatefulWidget {
  final String label;
  final void Function(UserCredential)? onSuccess;
  final void Function(Exception)? onError;
  const AppleAuthButton({
    super.key,
    required this.label,
    this.onSuccess,
    this.onError,
  });
  @override
  _AppleAuthButtonState createState() => _AppleAuthButtonState();
}
class _AppleAuthButtonState extends State<AppleAuthButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isProcessing = false;
  Future<void> _handleAppleSignIn() async {
    setState(() {
      _isProcessing = true;
    });
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);
      widget.onSuccess?.call(userCredential);
    } catch (exception) {
      widget.onError?.call(exception as Exception);
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => BlocProvider.of<AuthBloc>(context).add(AppleSignInRequested()),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF3C3C3C), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: _isProcessing ? Colors.grey[300] : Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isProcessing)
              const CircularProgressIndicator()
            else
              Image.asset('assets/icon/apple_icon.png', height: 32, width: 32),
            const SizedBox(width: 8),
            AutoSizeText(
              _isProcessing ? 'Processing...' : widget.label,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              minFontSize: 11,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
