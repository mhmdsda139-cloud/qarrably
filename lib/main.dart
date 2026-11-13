lib/main.dartimport 'package:flutter/material.dart';

void main() => runApp(const QarrablyApp());

const ink = Color(0xFF102D35);
const mint = Color(0xFF8BE0C5);

class QarrablyApp extends StatelessWidget {
  const QarrablyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'قَرّبلي',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: ink),
      scaffoldBackgroundColor: const Color(0xFFF4F6F5),
      appBarTheme: const AppBarTheme(backgroundColor: ink, foregroundColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    ),
    home: const Directionality(textDirection: TextDirection.rtl, child: MainShell()),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int tab = 0;
  final pages = const [HomePage(), LostPage(), ErrandPage(), HelpPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('قَرّبلي', style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [IconButton(onPressed: () => _message(context, 'الإشعارات ستتاح بعد ربط الخادم.'), icon: const Icon(Icons.notifications_none))]),
    body: pages[tab],
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab, onDestinationSelected: (v) => setState(() => tab = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.qr_code_2), label: 'المفقودات'),
        NavigationDestination(icon: Icon(Icons.delivery_dining), label: 'المشاوير'),
        NavigationDestination(icon: Icon(Icons.volunteer_activism), label: 'ساعد'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
      ]),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(24)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('حاجتك ترجعلك..', style: TextStyle(color: mint, fontSize: 25, fontWeight: FontWeight.bold)),
        Text('ومشوارك يتقضى.', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 8), Text('شبكة المساعدة اليومية في السويس', style: TextStyle(color: Colors.white70)),
      ])),
    const SizedBox(height: 18),
    ServiceTile(icon: Icons.qr_code_2, title: 'رجّعلي حاجتي', subtitle: 'المفقودات وملصقات QR', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LostPage()))),
    ServiceTile(icon: Icons.delivery_dining, title: 'اقضيلي مشواري', subtitle: 'شراء أو استلام أو توصيل', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ErrandPage())) ,
    ServiceTile(icon: Icons.volunteer_activism, title: 'أنا مستعد أساعد', subtitle: 'قدّم المساعدة للناس القريبة منك', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpPage()))),
    const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('الأمان أولاً: لا تنشر رقم هاتفك أو عنوان منزلك. التواصل الآمن والتحقق سيُفعّلان بعد ربط الخادم.'))),
  ]);
}

class ServiceTile extends StatelessWidget {
  final IconData icon; final String title, subtitle; final VoidCallback onTap;
  const ServiceTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(contentPadding: const EdgeInsets.all(14),
      leading: CircleAvatar(backgroundColor: mint, foregroundColor: ink, child: Icon(icon)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_left), onTap: onTap),
  );
}

class LostPage extends StatelessWidget {
  const LostPage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('رجّعلي حاجتي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8), const Text('اربط أغراضك بملصق QR، أو أبلغ عن غرض عثرت عليه.'),
    const SizedBox(height: 16),
    FilledButton.icon(onPressed: () => _message(context, 'إنشاء QR حقيقي يحتاج ربط قاعدة البيانات وإصدار رمز فريد.'), icon: const Icon(Icons.qr_code), label: const Text('إضافة غرض وإنشاء QR')),
    OutlinedButton.icon(onPressed: () => _message(context, 'بلاغ العثور سيُرسل بعد ربط الخدمة بالخادم.'), icon: const Icon(Icons.search), label: const Text('الإبلاغ عن غرض عثرت عليه')),
  ]);
}

class ErrandPage extends StatefulWidget {
  const ErrandPage({super.key});
  @override State<ErrandPage> createState() => _ErrandPageState();
}
class _ErrandPageState extends State<ErrandPage> {
  String kind = 'شراء غرض';
  final title = TextEditingController(), details = TextEditingController(), area = TextEditingController(text: 'السويس');
  @override void dispose() { title.dispose(); details.dispose(); area.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('اقضيلي مشواري', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 14),
    DropdownButtonFormField<String>(value: kind, decoration: const InputDecoration(labelText: 'نوع المشوار'),
      items: ['شراء غرض','استلام طلب','توصيل غرض','مساعدة بسيطة'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
      onChanged: (v) => setState(() => kind = v ?? kind)),
    const SizedBox(height: 12), TextField(controller: title, decoration: const InputDecoration(labelText: 'عنوان الطلب')),
    const SizedBox(height: 12), TextField(controller: details, maxLines: 3, decoration: const InputDecoration(labelText: 'التفاصيل')),
    const SizedBox(height: 12), TextField(controller: area, decoration: const InputDecoration(labelText: 'المنطقة داخل السويس')),
    const SizedBox(height: 18),
    FilledButton(onPressed: () {
      if (title.text.trim().isEmpty) { _message(context, 'اكتب عنوان الطلب أولاً.'); return; }
      _message(context, 'معاينة فقط: $kind — ${title.text}. لم يتم نشر الطلب فعلياً.');
    }, child: const Text('معاينة الطلب')),
  ]);
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override Widget build(BuildContext context) => const Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('أنا مستعد أساعد', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    SizedBox(height: 10), Text('في النسخة المتصلة ستسجل كمقدم خدمة وتحدد نطاقك وتستقبل الطلبات بعد التحقق من الحساب.'),
    SizedBox(height: 12), Text('لن يظهر رقمك أو عنوانك علناً.'),
  ]));
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) => const Padding(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('حسابي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    SizedBox(height: 10), Text('تسجيل الدخول وسجل الطلبات سيتم تفعيلهما بعد ربط Supabase.'),
  ]));
}
void _message(BuildContext context, String message) => showDialog(context: context, builder: (_) => AlertDialog(
  title: const Text('قَرّبلي'), content: Text(message),
  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))]));
