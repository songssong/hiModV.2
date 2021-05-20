import 'dart:convert';

import 'package:himod/service/auth_provider_service.dart';

class AuthGoogle{
  final String photoURL = AuthProviderService.instance.user.photoURL;
  final String displayName = AuthProviderService.instance.user.displayName;
  final String email = AuthProviderService.instance.user.email;
}