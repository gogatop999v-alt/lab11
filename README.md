# SRS 11 — Refactoring to Clean Architecture

## Запуск
```
flutter create .        # сгенерирует android/ios (lib и pubspec не затрагивает)
flutter pub get
flutter run
```
Android: в `android/app/src/main/AndroidManifest.xml` добавьте
`<uses-permission android:name="android.permission.INTERNET"/>`.

## Направление зависимостей
presentation -> domain <- data. Domain не импортирует Flutter, Dio, SharedPreferences.

## Обработка ошибок
| Ситуация | Исключение (Data) | Failure |
|---|---|---|
| Нет интернета / таймаут | NetworkException | NetworkFailure |
| 500 | ServerException | ServerFailure |
| 401/403 | UnauthorizedException | UnauthorizedFailure |
| 400 | ValidationException | ValidationFailure |
| Пустой список | — | состояние ProductEmpty |
| Прочее | любое | UnknownFailure |

Dio -> исключения: `core/rest_client/api_client.dart`.
Исключения -> Failure: `core/error/guard.dart`.
Failure -> текст для пользователя: `Failure.message`.

## Новая функция: Избранное с локальным сохранением
Entity.isFavorite, ToggleFavoriteUseCase, ProductLocalDataSource (SharedPreferences),
ProductRepository.toggleFavorite, событие ToggleFavorite в Bloc, фильтр «только избранное».

## Перенос в свой проект
Замените Product/ProductModel и endpoint на свои сущности, остальная структура та же.
