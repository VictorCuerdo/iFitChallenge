import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/../blocs/auth/auth_bloc.dart';
import '/../blocs/auth/auth_event.dart';

class GoogleAuthButton extends StatefulWidget {
  final String label;
  final void Function(UserCredential)? onSuccess;
  final void Function(Exception)? onError;
  const GoogleAuthButton({
    super.key,
    required this.label,
    this.onSuccess,
    this.onError,
  });
  @override
  _GoogleAuthButtonState createState() => _GoogleAuthButtonState();
}
class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isProcessing = false;
  Future<void> _handleGoogleSignIn() async {
    try {
      setState(() {
        _isProcessing = true;
      });
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        if (widget.onError != null) {
          widget.onError!(Exception('Google sign-in aborted'));
        }
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
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
      onTap: () => BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested()),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF3C3C3C), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: _isProcessing ? Colors.grey[300] : Colors.white,
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
              Image.asset('assets/icon/google_icon.png', height: 32, width: 32),
            const SizedBox(width: 8),
            AutoSizeText(
              _isProcessing ? 'Processing...' : widget.label,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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




