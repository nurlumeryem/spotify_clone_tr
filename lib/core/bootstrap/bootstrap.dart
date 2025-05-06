import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify_clone_tr/firebase_options.dart';
import 'package:spotify_clone_tr/service_locator.dart';
import 'package:supabase/supabase.dart';

late final SupabaseClient supabase;

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  try {
    supabase = SupabaseClient(
      dotenv.env['SUPABASE_URL']!,
      dotenv.env['SUPABASE_ANON_KEY']!,
    );
    print('SupabaseClient oluşturuldu.');
  } catch (e) {
    print('Supabase bağlantı hatası: $e');
  }

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  await initializeDependencies();

  runApp(await builder());
}
