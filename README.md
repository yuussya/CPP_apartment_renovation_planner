# Apartment Renovation Planner (Flutter Web)

Лабораторна робота №3 — базова структура застосунку та основні екрани (UI без бізнес-логіки).

## Екрани
- Вхід, реєстрація, відновлення пароля (запит листа + «Check your email»), встановлення нового пароля
- Головна сторінка (Dashboard)
- Профіль / Account Settings (дані профілю, сповіщення, зміна пароля)
- Rooms / Tasks / Spendings — заглушки (наступні лабораторні)

Усі дані захардкоджені (`lib/data/mock_data.dart`), зовнішніх залежностей немає.

## Структура
```
lib/
  main.dart, app.dart
  core/
    theme/     # кольори, відступи, ThemeData
    router/    # імена маршрутів та onGenerateRoute
    widgets/   # перевикористовувані віджети (поля, кнопки, картки, сайдбар…)
  data/        # mock-дані
  features/
    auth/screens/     # login, register, forgot_password, reset_password
    home/screens/     # home_screen
    profile/screens/  # profile_screen
    common/screens/   # placeholder_screen
test/widget_test.dart
```

## Запуск
```bash
flutter pub get
flutter run -d chrome
flutter test
```
Потрібен Flutter 3.27+ (використовується `Color.withValues`).

## Git
```bash
git init
git add .
git commit -m "Lab 3: auth, home and profile screens"
git branch -M main
git remote add origin https://github.com/<username>/apartment_renovation_planner.git
git push -u origin main
```
