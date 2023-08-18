Prerequisites https://grpc.io/docs/languages/dart/quickstart/#prerequisites

```shell
dart pub global activate protoc_plugin

dart pub get

protoc --dart_out=grpc:lib/src/generated -Iprotos protos/*
```



packages:

```yaml
dependencies:
  grpc: ^3.1.0
  protobuf: ^2.1.0
```

