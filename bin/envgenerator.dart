import 'package:envgenerator/config.dart';
import 'package:envgenerator/envgenerator.dart' as envgenerator;

Future<void> main(List<String> arguments) async {
  var args = [...arguments];
  if (args.isEmpty) {
    args.add('./dev.json');
    // print('Please provide an environment');
    // return;
  }
  final configPath = args.first;
  final config = Config.fromPath(configPath);
  final envGenerator = envgenerator.EnvGenerator(config);
  await envGenerator.makeTasks();
}
