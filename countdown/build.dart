import 'dart:io';

void main() async {
  print('Running build_runner...');
  final result = await Process.run('flutter', [
    'pub',
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
  print(result.stdout);
  if (result.stderr.toString().isNotEmpty) {
    print('Errors:');
    print(result.stderr);
  }
}
