```shell
dart pub get
dart run build_runner build --delete-conflicting-outputs

# https://pub.dev/documentation/stormberry/latest/topics/Migration-topic.html
DB_SSL=false dart run stormberry migrate
```
