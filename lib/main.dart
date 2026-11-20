import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'src/presentation/bloc/product_bloc.dart';
import 'src/presentation/bloc/product_event.dart';
import 'src/presentation/pages/products_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Shop Clean',
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: BlocProvider(
          create: (_) => getIt<ProductBloc>()..add(const LoadProducts()),
          child: const ProductsPage(),
        ),
      );
}
