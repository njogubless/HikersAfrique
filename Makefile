icons:
		dart run flutter_launcher_icons:main && dart run icons_launcher:create

splash:
		dart run flutter_native_splash:create

gen:
		dart run build_runner build --delete-conflicting-outputs

fmt:
		dart format lib test

localize:
		flutter gen-l10n

get:
		flutter pub get

clean:
		flutter pub clean

install:
		flutter pub add "%2"

installdev:
		flutter pub add -d "%2"

apk:
		flutter build apk  --flavor production --target lib/main_production.dart

sort:
		dart run import_sorter:main

aab:
		flutter build appbundle  --flavor production --target lib/main_production.dart

run:
		flutter run --release  --flavor production --target lib/main_production.dart

build: 	# Run the app on a new computer with Flutter 2.3 installed
		flutter pub get && make gen && make run

ipa:
		flutter build ipa  --flavor production --target lib/main_production.dart -vv

build-dev-web:
		flutter build web --target lib/main_development.dart

build-dev:
		flutter build apk  --flavor development --target lib/main_development.dart

dev:
		flutter run --flavor development --target lib/main_development.dart

dev-web:
		flutter run --flavor development --target lib/main_development.dart -d chrome

build-stg-web:
		flutter build web --target lib/main_staging.dart

build-stg:
		flutter build apk --flavor staging --target lib/main_staging.dart

staging:
		flutter run --flavor staging --target lib/main_staging.dart

staging-web:
		flutter run --flavor staging --target lib/main_staging.dart -d chrome

run_web:
		flutter run  --flavor production --target lib/main_production.dart -d chrome

build-prod-web:
		flutter build web --target lib/main_production.dart

build-prod:
		flutter build apk  --flavor production --target lib/main_production.dart

prod:
		flutter run --flavor production --target lib/main_production.dart

prod-web:
		flutter run --flavor production --target lib/main_production.dart -d chrome

deploy-staging:
		firebase deploy --only hosting:onspace-staging

deploy-prod:
		firebase deploy

commit-empty:
		git commit --allow-empty -m "Trigger build"

fix:
		dart fix --apply

patch:
		shorebird patch android --target lib/main_production.dart --flavor production
        