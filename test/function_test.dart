import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

const defaultTimeout = Timeout(Duration(seconds: 3));

void main() {
  test('defaults', () async {
    final proc =
        await TestProcess.start('dart', ['bin/server.dart', '--port', '5000']);

    final response = await get(Uri.parse('http://localhost:5000'));
    expect(response.statusCode, 200);
    expect(response.body, 'Page not found');

    proc.kill();
  }, timeout: defaultTimeout);
}
