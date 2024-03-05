import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '/../blocs/auth/auth_bloc.dart';
import '/../blocs/auth/auth_event.dart';

class FacebookAuthButton extends StatefulWidget {
  final String label;
  final void Function(UserCredential)? onSuccess;
  final void Function(Exception)? onError;
  const FacebookAuthButton({
    super.key,
    required this.label,
    this.onSuccess,
    this.onError,
  });
  @override
  _FacebookAuthButtonState createState() => _FacebookAuthButtonState();
}
class _FacebookAuthButtonState extends State<FacebookAuthButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isProcessing = false;

  Future<void> _handleFacebookSignIn() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        widget.onSuccess?.call(userCredential);
      } else if (loginResult.status == LoginStatus.cancelled) {
        widget.onError?.call(Exception('Facebook sign-in was cancelled'));
      } else {
        widget.onError?.call(Exception(loginResult.message));
      }
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
      onTap: () => BlocProvider.of<AuthBloc>(context).add(FacebookSignInRequested()),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF3C3C3C), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: _isProcessing ? Colors.grey[300] : const Color(0xFF1877F2),
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
              Image.asset('assets/icon/facebook_icon.png', height: 32, width: 32),
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



