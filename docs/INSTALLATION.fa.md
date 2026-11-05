# نصب در ویندوز

## پیش‌نیاز

Node.js نسخه 22.12.0 یا بالاتر لازم است. دریافت از https://nodejs.org/

## نصب

1. Antigravity را کاملاً ببند.
2. پروژه را Extract کن.
3. `installer\Install.bat` را اجرا کن.
4. اسکریپت مسیر پیش‌فرض `%LOCALAPPDATA%\Programs\antigravity\resources` را بررسی می‌کند.
5. سورس پروژه بالادستی را از GitHub دریافت می‌کند.
6. وابستگی‌ها را نصب و پروژه را Build می‌کند.
7. دستور preflight بالادستی را اجرا می‌کند.
8. فقط در صورت موفقیت preflight و تأیید صریح کاربر، deployment اجرا می‌شود.

## مسیر سفارشی

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\installer\Install-AvalAI.ps1 -Resources "D:\Apps\Antigravity\resources"
```

## فقط بررسی، بدون نصب

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\installer\Install-AvalAI.ps1 -CheckOnly
```

## لاگ

لاگ‌ها در مسیر زیر ذخیره می‌شوند:

```text
%LOCALAPPDATA%\AvalAI-Antigravity-Bridge\logs
```

## هشدار

اگر preflight پیام unsupported runtime یا هر خطای سازگاری داد، نصب را دور نزن. خروجی و لاگ را برای بررسی نگه دار.
