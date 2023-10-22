import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
      child: Consumer<Connection>(
        builder: (context, connection, _) {
          return connection.status
              ? const SizedBox()
              : Icon(
                  Icons.wifi_off,
                  color: Theme.of(context).errorColor,
                );
        },
      ),
    );
  }
}
