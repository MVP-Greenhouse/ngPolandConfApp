import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_app/config/app_config.dart';
import 'package:ng_poland_conf_app/features/about/domains/entities/author.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/presentation/connection_status.dart';

const _pink = Color(0xFFFF2D87);
const _gold = Color(0xFFF5C518);
const _violet = Color(0xFF7B5CFF);

const _repoUrl = 'https://github.com/MVP-Greenhouse/ngPolandConfApp';

const _authors = [
  Author(
    name: 'Daniel Michalak',
    image: 'danielmichalak',
    linkedinUrl: 'https://www.linkedin.com/in/daniel-michalak-0219981b2/',
  ),
  Author(
    name: 'Sebastian Denis',
    image: 'sebastiandenis',
    linkedinUrl: 'https://www.linkedin.com/in/sebastian-denis-0a1782153/',
  ),
  Author(
    name: 'Dariusz Kalbarczyk',
    image: 'dariuszkalbarczyk',
    linkedinUrl: 'https://www.linkedin.com/in/ngkalbarczyk/',
  ),
];

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: context.palette.screen,
        child: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 28, 16, 32),
          child: Column(
            children: [
              _LogoCluster(),
              SizedBox(height: 22),
              _FlutterPill(),
              SizedBox(height: 28),
              _SectionTitle(title: 'AUTHORS', trailing: 'Core Team'),
              SizedBox(height: 12),
              _AuthorList(),
              SizedBox(height: 28),
              _SectionTitle(title: 'OPEN SOURCE'),
              SizedBox(height: 12),
              _RepoCard(),
              SizedBox(height: 36),
              _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoCluster extends StatelessWidget {
  const _LogoCluster();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ConferenceMark(
          asset: 'assets/images/ngpolandlogo.png',
          label: 'NG-POLAND',
          colors: [_pink, Color(0xFFC026D3)],
          labelColor: _pink,
          size: 124,
        ),
        SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ConferenceMark(
              asset: 'assets/images/jspolandlogo.png',
              label: 'JS-POLAND',
              colors: [Color(0xFFFFB703), _gold],
              labelColor: _gold,
              size: 104,
            ),
            SizedBox(width: 36),
            _ConferenceMark(
              asset: 'assets/images/aipolandlogo.png',
              label: 'AI-POLAND',
              colors: [Color(0xFF3B82F6), _violet],
              labelColor: Color(0xFFB9A6FF),
              size: 104,
            ),
          ],
        ),
      ],
    );
  }
}

class _ConferenceMark extends StatelessWidget {
  const _ConferenceMark({
    required this.asset,
    required this.label,
    required this.colors,
    required this.labelColor,
    required this.size,
  });

  final String asset;
  final String label;
  final List<Color> colors;
  final Color labelColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.45),
                blurRadius: 28,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF160E1E),
              ),
              child: Padding(
                padding: EdgeInsets.all(size * 0.22),
                child: Image.asset(asset, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

class _FlutterPill extends StatelessWidget {
  const _FlutterPill();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.panel,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: palette.accent,
                shape: BoxShape.circle,
              ),
              child: const SizedBox(width: 8, height: 8),
            ),
            const SizedBox(width: 8),
            Text(
              'This app is built with Flutter!',
              style: TextStyle(
                color: palette.onCard,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.bolt, color: _gold, size: 16),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: palette.muted,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        if (trailing case final label?)
          Text(
            label,
            style: TextStyle(
              color: palette.accent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _AuthorList extends StatelessWidget {
  const _AuthorList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, author) in _authors.indexed) ...[
          if (index > 0) const SizedBox(height: 10),
          _AuthorCard(author: author),
        ],
      ],
    );
  }
}

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({required this.author});

  final Author author;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final icon = author.image == 'dariuszkalbarczyk'
        ? Icons.event
        : Icons.code;
    return Material(
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(author.linkedinUrl)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/authors/${author.image}.jpg',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  author.name,
                  style: TextStyle(
                    color: palette.onCard,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(icon, color: palette.accent, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _RepoCard extends StatelessWidget {
  const _RepoCard();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Material(
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(_repoUrl)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.chip,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.github,
                      color: palette.accent,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ngPolandConfApp',
                  style: TextStyle(
                    color: palette.onCard,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(Icons.open_in_new, color: palette.accent, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(color: palette.muted, fontSize: 13),
            children: [
              const TextSpan(text: 'Made with '),
              TextSpan(
                text: '♥',
                style: TextStyle(color: palette.accent),
              ),
              const TextSpan(text: ' for the Angular Community'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Version: ${AppConfig.version}',
          style: TextStyle(color: palette.muted, fontSize: 12),
        ),
      ],
    );
  }
}
