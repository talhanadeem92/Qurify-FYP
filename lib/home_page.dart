import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
//
// Mockup classes and constants
class NamedRoutes {
  static const bookmarkScreen = '/bookmarkScreen';
}

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState());
  void add(FetchSurah event) {}
}

class FetchSurah {}

class HomeState {
  final StatusSurah statusSurah = StatusSurah();
}

class StatusSurah {
  final Status status = Status();
  String get message => 'Some message';
  List<String>? get data => ['Surah Al-Fatihah', 'Surah Al-Baqarah'];
}

class Status {
  bool get isLoading => false;
  bool get isNoData => false;
  bool get isError => false;
  bool get isHasData => true;
}

// class LastReadCubit extends Cubit<void> {
//   LastReadCubit() : super(null);
//   void getLastRead() {}
// }

class PreferenceSettingsProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  void enableDarkTheme(bool value) {
    isDarkTheme = value;
    notifyListeners();
  }
}

class BannerLastReadWidget extends StatelessWidget {
  const BannerLastReadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.grey,
      child: Center(child: Text('Banner Last Read Placeholder')),
    );
  }
}

class ListSurahWidget extends StatelessWidget {
  final List<String> surah;
  final PreferenceSettingsProvider prefSetProvider;

  const ListSurahWidget(
      {required this.surah, required this.prefSetProvider, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: surah.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            surah[index],
            style: TextStyle(
                color: prefSetProvider.isDarkTheme
                    ? Colors.white
                    : Colors.black),
          ),
        );
      },
    );
  }
}

// Main Code
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => PreferenceSettingsProvider()),
    //     BlocProvider(create: (_) => HomeBloc()),
    //     BlocProvider(create: (_) => LastReadCubit()),
    //   ],
      child: MaterialApp(
        title: 'Quran App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        routes: {
          NamedRoutes.bookmarkScreen: (context) =>
              Scaffold(body: Center(child: Text('Bookmark Screen'))),
        },
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeBloc>().add(FetchSurah());
      context.read<LastReadCubit>().getLastRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, prefSetProvider, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32.0, horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowUpAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            prefSetProvider.isDarkTheme
                                ? 'assets/icon_quran_white.png'
                                : 'assets/icon_quran.png',
                            width: 28.0,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, NamedRoutes.bookmarkScreen),
                            child: Image.asset(
                              prefSetProvider.isDarkTheme
                                  ? 'assets/icon_bookmark_white1.png'
                                  : 'assets/icon_bookmark1.png',
                              width: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const BannerLastReadWidget(),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        final status = state.statusSurah.status;
                        if (status.isHasData) {
                          final surah = state.statusSurah.data ?? [];
                          return ListSurahWidget(
                            surah: surah,
                            prefSetProvider: prefSetProvider,
                          );
                        }
                        return const Center(child: Text('Error BLoC'));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
