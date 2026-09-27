import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const TooleApp());

class AppState extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  Color accent = const Color(0xFF4FC3F7);
  Locale locale = const Locale('fr');

  void setTheme(ThemeMode value) { themeMode = value; notifyListeners(); }
  void setAccent(Color value) { accent = value; notifyListeners(); }
  void setLocale(Locale value) { locale = value; notifyListeners(); }
}

class TooleApp extends StatefulWidget {
  const TooleApp({super.key});
  @override State<TooleApp> createState() => _TooleAppState();
}

class _TooleAppState extends State<TooleApp> {
  final state = AppState();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: state,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TooLe',
        locale: state.locale,
        supportedLocales: const [Locale('fr'), Locale('en'), Locale('mo')],
        localizationsDelegates: const [
          AppStrings.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        themeMode: state.themeMode,
        theme: _theme(Brightness.light, state.accent),
        darkTheme: _theme(Brightness.dark, state.accent),
        home: AuthScreen(state: state),
      ),
    );
  }

  ThemeData _theme(Brightness brightness, Color accent) {
    final dark = brightness == Brightness.dark;
    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorSchemeSeed: accent,
    );
    return base.copyWith(
      scaffoldBackgroundColor: dark ? const Color(0xFF07111D) : const Color(0xFFF5F8FB),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class AppStrings {
  final Locale locale;
  AppStrings(this.locale);

  static const delegate = _AppStringsDelegate();

  static const data = {
    'fr': {
      'app': 'TooLe', 'login': 'Connexion', 'register': 'Inscription',
      'identifier': 'Téléphone ou e-mail', 'password': 'Mot de passe',
      'create': 'Créer mon compte', 'connect': 'Se connecter',
      'already': "J'ai déjà un compte", 'new': "Pas encore de compte ?",
      'home': 'Accueil', 'chat': 'Chat', 'group': 'Group', 'status': 'Statut',
      'special': 'Special', 'settings': 'Paramètres', 'ai': 'TooLe AI',
      'game': 'Jeu', 'appearance': 'Apparence', 'language': 'Langue',
      'light': 'Clair', 'dark': 'Sombre', 'colors': 'Couleur d’accent',
      'welcome': 'Bienvenue sur TooLe', 'demo': 'Version prototype',
      'aiText': 'Ton assistant intelligent intégré à TooLe.',
      'gameText': 'Un jeu intégré à l’application.',
    },
    'en': {
      'app': 'TooLe', 'login': 'Login', 'register': 'Sign up',
      'identifier': 'Phone or email', 'password': 'Password',
      'create': 'Create account', 'connect': 'Sign in',
      'already': 'I already have an account', 'new': "Don't have an account?",
      'home': 'Home', 'chat': 'Chat', 'group': 'Group', 'status': 'Status',
      'special': 'Special', 'settings': 'Settings', 'ai': 'TooLe AI',
      'game': 'Game', 'appearance': 'Appearance', 'language': 'Language',
      'light': 'Light', 'dark': 'Dark', 'colors': 'Accent color',
      'welcome': 'Welcome to TooLe', 'demo': 'Prototype version',
      'aiText': 'Your intelligent assistant built into TooLe.',
      'gameText': 'A game built into the app.',
    },
    'mo': {
      'app': 'TooLe', 'login': 'Kẽesgo', 'register': 'Yʋʋgã',
      'identifier': 'Téléphone walla e-mail', 'password': 'Sõngre',
      'create': 'Yʋʋgã', 'connect': 'Kẽesg-a',
      'already': 'Mam tara compte', 'new': 'Compte pa ye?',
      'home': 'Accueil', 'chat': 'Chat', 'group': 'Group', 'status': 'Statut',
      'special': 'Special', 'settings': 'Paramètres', 'ai': 'TooLe AI',
      'game': 'Jeu', 'appearance': 'Apparence', 'language': 'Langa',
      'light': 'Yĩnga', 'dark': 'Yõodo', 'colors': 'Couleur',
      'welcome': 'Wẽnnaam TooLe', 'demo': 'Prototype',
      'aiText': 'Assistant intelligent TooLe.',
      'gameText': 'Jeu intégré à TooLe.',
    },
  };

  String t(String key) => data[locale.languageCode]?[key] ?? data['fr']![key] ?? key;
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();
  @override bool isSupported(Locale locale) => ['fr','en','mo'].contains(locale.languageCode);
  @override Future<AppStrings> load(Locale locale) async => AppStrings(locale);
  @override bool shouldReload(_AppStringsDelegate old) => false;
}

class AuthScreen extends StatefulWidget {
  final AppState state;
  const AuthScreen({super.key, required this.state});
  @override State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;
  final id = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(Localizations.localeOf(context));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  _Logo(),
                  const SizedBox(height: 24),
                  Text(login ? s.t('login') : s.t('register'),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(s.t('demo')),
                  const SizedBox(height: 28),
                  TextField(controller: id, decoration: InputDecoration(labelText: s.t('identifier'), prefixIcon: const Icon(Icons.alternate_email))),
                  const SizedBox(height: 14),
                  TextField(controller: pass, obscureText: true, decoration: InputDecoration(labelText: s.t('password'), prefixIcon: const Icon(Icons.lock_outline))),
                  const SizedBox(height: 22),
                  SizedBox(width: double.infinity, height: 54,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainShell(state: widget.state))),
                      icon: Icon(login ? Icons.login_rounded : Icons.person_add_alt_1_rounded),
                      label: Text(login ? s.t('connect') : s.t('create')),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() => login = !login),
                    child: Text(login ? '${s.t('new')} ${s.t('register')}' : '${s.t('already')} → ${s.t('login')}'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override Widget build(BuildContext context) => Container(
    width: 86, height: 86,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]),
      boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.3), blurRadius: 24)],
    ),
    child: const Icon(Icons.hub_rounded, size: 48, color: Colors.white),
  );
}

class MainShell extends StatefulWidget {
  final AppState state;
  const MainShell({super.key, required this.state});
  @override State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  @override Widget build(BuildContext context) {
    final s = AppStrings(Localizations.localeOf(context));
    final pages = [
      _ChatPage(title: s.t('chat')),
      _SimplePage(icon: Icons.groups_2_rounded, title: s.t('group'), text: 'Groupes et communautés'),
      _SimplePage(icon: Icons.radio_button_checked_rounded, title: s.t('status'), text: 'Statuts et publications temporaires'),
      _SpecialPage(s: s),
      SettingsPage(state: widget.state),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(s.t(['chat','group','status','special','settings'][index])), centerTitle: true),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: [
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), selectedIcon: Icon(Icons.chat_bubble_rounded), label: s.t('chat')),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups_rounded), label: s.t('group')),
          NavigationDestination(icon: Icon(Icons.radio_button_unchecked_rounded), selectedIcon: Icon(Icons.radio_button_checked_rounded), label: s.t('status')),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome_rounded), label: s.t('special')),
          NavigationDestination(icon: Icon(Icons.tune_outlined), selectedIcon: Icon(Icons.tune_rounded), label: s.t('settings')),
        ],
      ),
    );
  }
}

class _ChatPage extends StatelessWidget {
  final String title;
  const _ChatPage({required this.title});
  @override Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Rechercher')),
      const SizedBox(height: 16),
      _ChatTile(name: 'Bienvenue sur TooLe', message: 'CNS.corp • Prototype', icon: Icons.hub_rounded),
      _ChatTile(name: 'Conversation', message: 'Ta messagerie TooLe commence ici.', icon: Icons.forum_rounded),
    ],
  );
}

class _ChatTile extends StatelessWidget {
  final String name, message; final IconData icon;
  const _ChatTile({required this.name, required this.message, required this.icon});
  @override Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
      trailing: const Icon(Icons.chevron_right_rounded),
    ),
  );
}

class _SimplePage extends StatelessWidget {
  final IconData icon; final String title, text;
  const _SimplePage({required this.icon, required this.title, required this.text});
  @override Widget build(BuildContext context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 86, color: Theme.of(context).colorScheme.primary),
      const SizedBox(height: 18), Text(title, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8), Text(text),
    ]),
  );
}

class _SpecialPage extends StatelessWidget {
  final AppStrings s;
  const _SpecialPage({required this.s});
  @override Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _FeatureCard(icon: Icons.smart_toy_rounded, title: s.t('ai'), description: s.t('aiText'), onTap: () {}),
      _FeatureCard(icon: Icons.sports_esports_rounded, title: s.t('game'), description: s.t('gameText'), onTap: () {}),
    ],
  );
}

class _FeatureCard extends StatelessWidget {
  final IconData icon; final String title, description; final VoidCallback onTap;
  const _FeatureCard({required this.icon, required this.title, required this.description, required this.onTap});
  @override Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 16),
    child: InkWell(
      borderRadius: BorderRadius.circular(20), onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(22), child: Row(children: [
        Container(width: 58, height: 58, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(18)), child: Icon(icon, size: 30)),
        const SizedBox(width: 18), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5), Text(description),
        ])), const Icon(Icons.arrow_forward_ios_rounded, size: 17)
      ])),
    ),
  );
}

class SettingsPage extends StatelessWidget {
  final AppState state;
  const SettingsPage({super.key, required this.state});
  @override Widget build(BuildContext context) {
    final s = AppStrings(Localizations.localeOf(context));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle(s.t('appearance')),
        Card(child: Column(children: [
          RadioListTile<ThemeMode>(value: ThemeMode.dark, groupValue: state.themeMode, onChanged: (v) => state.setTheme(v!), title: Text(s.t('dark')), secondary: const Icon(Icons.dark_mode_rounded)),
          RadioListTile<ThemeMode>(value: ThemeMode.light, groupValue: state.themeMode, onChanged: (v) => state.setTheme(v!), title: Text(s.t('light')), secondary: const Icon(Icons.light_mode_rounded)),
          const Divider(),
          Padding(padding: const EdgeInsets.fromLTRB(18, 8, 18, 4), child: Align(alignment: Alignment.centerLeft, child: Text(s.t('colors'), style: const TextStyle(fontWeight: FontWeight.bold)))),
          Wrap(spacing: 10, children: [
            _color(state, const Color(0xFF4FC3F7)), _color(state, const Color(0xFF00C853)),
            _color(state, const Color(0xFFFF4081)), _color(state, const Color(0xFFFFB300)),
            _color(state, const Color(0xFF7C4DFF)),
          ]),
          const SizedBox(height: 16),
        ])),
        const SizedBox(height: 12),
        _sectionTitle(s.t('language')),
        Card(child: Column(children: [
          _lang(state, const Locale('fr'), '🇫🇷 Français'),
          _lang(state, const Locale('en'), '🇬🇧 English'),
          _lang(state, const Locale('mo'), '🇧🇫 Mooré'),
        ])),
        const SizedBox(height: 24),
        Center(child: Text('TooLe • CNS.corp • v0.1.0', style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
  Widget _sectionTitle(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)));
  Widget _color(AppState st, Color c) => Padding(padding: const EdgeInsets.all(4), child: GestureDetector(onTap: () => st.setAccent(c), child: CircleAvatar(backgroundColor: c, child: st.accent.value == c.value ? const Icon(Icons.check, color: Colors.white) : null)));
  Widget _lang(AppState st, Locale l, String label) => RadioListTile<Locale>(value: l, groupValue: st.locale, onChanged: (v) => st.setLocale(v!), title: Text(label));
}
