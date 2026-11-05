# راهنمای اتصال AvalAI

## مقادیر اتصال

مستندات رسمی AvalAI، آدرس پایه زیر را معرفی می‌کند:

```text
https://api.avalai.ir/v1
```

برای Chat Completions:

```text
https://api.avalai.ir/v1/chat/completions
```

احراز هویت:

```http
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json
```

## مراحل در Antigravity

1. Antigravity را اجرا کن.
2. وارد Settings شو.
3. بخش Models & Usage و سپس Custom Models را باز کن.
4. Add model را انتخاب کن.
5. یک Provider با پروتکل OpenAI-compatible / Chat Completions ایجاد کن.
6. اگر فیلد Base URL می‌بینی، `https://api.avalai.ir/v1` را وارد کن.
7. اگر فیلد Endpoint کامل می‌خواهد، از `https://api.avalai.ir/v1/chat/completions` استفاده کن.
8. کلید API را فقط در فیلد محلی API Key وارد کن.
9. شناسه دقیق مدل را از پنل یا مستندات AvalAI بردار.
10. Test connection و سپس یک درخواست واقعی تولید پاسخ اجرا کن.

## نکات مهم

- مسیر `/v1` را دوبار اضافه نکن.
- اگر رابط کاربری خودش `/chat/completions` را اضافه می‌کند، فقط Base URL را وارد کن.
- نام نمایشی مثل `Claude Opus (AvalAI)` می‌تواند دلخواه باشد؛ اما Model ID باید دقیقاً همان شناسه‌ای باشد که AvalAI برای API اعلام می‌کند.
- موفقیت در دریافت فهرست مدل‌ها لزوماً به معنی داشتن مجوز تولید پاسخ یا اعتبار کافی نیست.
- اگر مدل در فهرست نبود، ورود دستی شناسه مدل را امتحان کن.
- پشتیبانی از ابزارها، تصاویر، reasoning و سقف context به مدل و مسیر API وابسته است؛ همه قابلیت‌های APIهای اصلی لزوماً از طریق یک لایه سازگار منتقل نمی‌شوند.

## عیب‌یابی

- `401`: کلید API یا هدر Authorization را بررسی کن.
- `403`: دسترسی حساب، محدودیت منطقه‌ای یا مجوز مدل را بررسی کن.
- `404`: Base URL، مسیر endpoint و Model ID را بررسی کن.
- `429`: محدودیت نرخ یا اعتبار حساب را بررسی کن.
- خطای Streaming: بررسی کن پروتکل انتخاب‌شده Chat Completions باشد و Provider از SSE پشتیبانی کند.
