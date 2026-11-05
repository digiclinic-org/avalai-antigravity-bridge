# به‌روزرسانی Antigravity و افزونه

## آیا بعد از آپدیت Antigravity نصب مجدد لازم است؟

ممکن است. آپدیت برنامه می‌تواند `app.asar` یا بخش‌های runtime را جایگزین کند و Patch قبلی را حذف یا ناسازگار کند.

## روش پیشنهادی پس از هر آپدیت

1. Antigravity را ببند.
2. نسخه جدید برنامه را اجرا نکن تا بررسی تمام شود.
3. `installer\Check-Compatibility.ps1` را اجرا کن (اگر سورس قبلاً دانلود شده باشد).
4. یا `installer\Install-AvalAI.ps1 -CheckOnly` را اجرا کن تا سورس به‌روز دریافت و preflight اجرا شود.
5. اگر preflight موفق بود، `installer\Install-AvalAI.ps1` را اجرا و deployment را تأیید کن.
6. اگر preflight ناموفق بود، نصب را متوقف کن و گزارش را بررسی کن.

## چرا نصب خودکار و بی‌قیدوشرط انجام نمی‌شود؟

Patch کردن runtime داخلی برنامه با تغییر نسخه ممکن است باعث Crash یا از کار افتادن برنامه شود. بنابراین این پروژه عمداً به‌روزرسانی خودکار و بی‌بررسی انجام نمی‌دهد. برای اتوماسیون کامل باید سازگاری نسخه جدید تأیید شده باشد و کاربر نیز نصب مجدد را opt-in کرده باشد.

## بازگردانی

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\installer\Restore-Antigravity.ps1
```

Restore فقط در چارچوب backup و fingerprintهایی انجام می‌شود که ابزار اصلی مدیریت می‌کند. پس از آپدیت، نباید یک backup قدیمی را کورکورانه روی runtime جدید بازگرداند.
