# قَرّبلي — مشروع Android (Flutter)

## الحالة
مشروع Flutter مصدره جاهز كبداية، وليس APK مبنياً أو تطبيقاً متصلاً بالخادم حتى الآن.

## بناء APK
1. ثبّت Flutter SDK وAndroid Studio على كمبيوتر.
2. افتح الطرفية داخل هذا المجلد.
3. نفّذ:
   ```bash
   flutter create .
   flutter pub get
   flutter run
   flutter build apk --release
   ```
4. ملف APK الناتج سيكون في:
   `build/app/outputs/flutter-apk/app-release.apk`

## قاعدة البيانات
أنشئ مشروع Supabase ثم نفّذ `supabase/schema.sql` في SQL Editor.
راجع سياسات RLS واختبرها قبل نشر بيانات حقيقية.

## الوظائف الموجودة في هذه النسخة
- واجهة عربية RTL وهوية قَرّبلي.
- الرئيسية والتنقل بين المفقودات والمشاوير والمساعدة والحساب.
- نموذج معاينة محلي لطلب مشوار.

## غير متصل بعد
تسجيل الدخول، النشر الفعلي، توليد QR، الرسائل، الإشعارات، التحقق من الهوية والدفع.
لا تضع مفتاح Supabase service_role داخل تطبيق الهاتف.
