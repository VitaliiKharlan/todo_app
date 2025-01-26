# todo_app

A new Flutter project.

## Getting Started


# how to change native splash

flutter clean
flutter pub get
flutter pub run flutter_native_splash:create

dart run flutter_native_splash:create --path=flutter_native_splash.yaml


# how to change launcher icon

flutter pub get
flutter pub run flutter_launcher_icons


# how to run build_runner

flutter packages pub run build_runner watch
flutter pub run build_runner build --delete-conflicting-outputs


# how to run auto_route

flutter packages pub run build_runner build
flutter packages pub run build_runner watch


# how to add a commit

git commit -m "add readme"
git add .
git commit -m "add readme"
git branch -M main
git push -u main
