import 'package:grpc/grpc.dart';
import '../lib/src/generated/helloworld.pb.dart';
import '../lib/src/generated/helloworld.pbgrpc.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = GreeterClient(channel);

  final name = 'Sazzad Hossain';

  try {
    final response = await stub.sayHello(
      HelloRequest()..name = name,
      options: CallOptions(compression: const GzipCodec()),
    );
    print('${response.message}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}
