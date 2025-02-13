

import '../../../exports_main.dart';

class AppErrorAlert extends StatelessWidget {
  const AppErrorAlert({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            navigator?.pop();
          },
          child: const Text(
            'close',
          ),
        ),
      ],
    );
  }
}
