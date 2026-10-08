import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FaIconData agendaIcon(String iconName, String type) {
  return switch (iconName) {
    'fa-microphone' => FontAwesomeIcons.microphone,
    'fa-laptop' => FontAwesomeIcons.laptop,
    'fa-coffee' => FontAwesomeIcons.mugSaucer,
    'fa-cutlery' => FontAwesomeIcons.utensils,
    'fa-trophy' => FontAwesomeIcons.trophy,
    'fa-file-text-o' => FontAwesomeIcons.fileLines,
    'fa-diamond' => FontAwesomeIcons.gem,
    _ => switch (type) {
      'registration' => FontAwesomeIcons.fileLines,
      'welcome' => FontAwesomeIcons.gem,
      'presentation' || 'talk' || 'keynote' || 'panel' => FontAwesomeIcons.microphone,
      'eating' || 'lunch' => FontAwesomeIcons.utensils,
      'award' || 'awards' => FontAwesomeIcons.trophy,
      'break' => FontAwesomeIcons.mugSaucer,
      'qa' => FontAwesomeIcons.circleQuestion,
      'workshop' => FontAwesomeIcons.laptop,
      _ => FontAwesomeIcons.circle,
    },
  };
}
