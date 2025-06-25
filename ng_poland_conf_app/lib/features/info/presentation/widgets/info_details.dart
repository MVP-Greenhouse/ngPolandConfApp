import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/info/domains/entities/info_item.dart';

class InfoDetails extends StatelessWidget {
  final InfoItem info;

  const InfoDetails({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  getIcon(info.icon).icon,
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                  size: 50,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Text(
                  info.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                SelectableText(
                  info.description ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).dividerTheme.color,
          )
        ],
      ),
    );
  }

  Icon getIcon(String? iconName) {
    switch (iconName) {
      case 'workshops':
        return const Icon(Icons.laptop);
      case 'food':
        return const Icon(Icons.fastfood);
      case 'contact':
        return const Icon(Icons.phone);
      case 'tickets':
        return const Icon(Icons.confirmation_number);
      case 'location':
        return const Icon(Icons.location_on);
      default:
        return const Icon(Icons.info);
    }
  }
}
