import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/about/domains/entities/author.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const List<Author> _dataAuthors = [
    Author(
      name: 'Daniel Michalak',
      image: 'danielmichalak',
      twitterUrl: 'https://twitter.com/MichalakDaniel2',
    ),
    Author(
      name: 'Sebastian Denis',
      image: 'sebastiandenis',
      twitterUrl: 'https://twitter.com/SebekD',
    ),
    Author(
      name: 'Dariusz Kalbarczyk',
      image: 'dariuszkalbarczyk',
      twitterUrl: 'https://twitter.com/ngKalbarczyk',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset('assets/images/logo.png'),
              ),
              const Text(
                'This app is built with Flutter!',
              ),
              Divider(
                color: Theme.of(context).dividerTheme.color,
                height: 35,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Authors:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Column(
                children: _dataAuthors
                    .map(
                      (author) => Column(
                        children: [
                          ListTile(
                            onTap: () => launchUrl(Uri.parse(author.twitterUrl)),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/authors/${author.image}.jpg',
                                height: 50,
                              ),
                            ),
                            title: Text(
                              author.name,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Divider(
                color: Theme.of(context).dividerTheme.color,
                height: 35,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/github.png',
                  height: 50,
                ),
                title: InkWell(
                  onTap: () => launchUrl(Uri.parse('https://github.com/gdgradzymin/ngPolandConfNext')),
                  child: const Text(
                    'ngPolandConfNext',
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Version: 4.0.0',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.secondary, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
