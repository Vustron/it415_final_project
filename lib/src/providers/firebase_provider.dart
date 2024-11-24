import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Provider<FirebaseAuth> firebaseAuthService = Provider<FirebaseAuth>(
    (ProviderRef<FirebaseAuth> ref) => FirebaseAuth.instance);

final Provider<FirebaseFirestore> firebaseFirestoreService =
    Provider<FirebaseFirestore>(
        (ProviderRef<Object?> ref) => FirebaseFirestore.instance);

final Provider<FirebaseStorage> firebaseStorageService =
    Provider<FirebaseStorage>(
        (ProviderRef<FirebaseStorage> ref) => FirebaseStorage.instance);
