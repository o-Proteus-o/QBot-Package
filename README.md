# QBot

A customizable and easy-to-use chatbot widget for Flutter apps. With `q_chat_bot`, you can quickly integrate a chatbot that responds to user input based on predefined keywords and responses. Fully customizable UI, including bot and user message styles, icons, and background colors.

## Demo
<p align="center"><img src="https://github.com/user-attachments/assets/4c5f21ff-3041-417e-9770-73fe1f0f7c4e"  alt="QBotDemo" height="844" width="431.38"/></p>

## Features

- Customizable chat bubbles for both user and bot.
- Support for bot and user avatars.
- Automatic response generation based on user input.
- Support for customizable welcome messages and typing indicators.
- Easy to integrate with any Flutter app.

## Getting started

To add `q_chat_bot` to your Flutter project, open your `pubspec.yaml` file and add it to your dependencies:

 ```yaml
 dependencies:
   q_chat_bot: ^1.0.0
```

## Usage

First, You need to customize the `QBot`

```dart
QBotConfig config = QBotConfig(
      // Required arguments
      txtFieldPadding: EdgeInsets.fromLTRB(8, 8, 0, 8),
      msgController: msgController,
      hintText: 'Type / for suggestions.',
      welcomeMsg: 'Hi, I\'m Q-Bot. How can I assest you?',
      botIcon: Icon(Icons.android, color: Colors.white),
      botMsgBgColor: Colors.green,
      userIcon: Icon(Icons.person, color: Colors.white),
      userMsgBgColor: Colors.blue,
      paddingBetweenMsgs: 8.0,
      keywords: ['Hello', 'What are you', 'thanks'],
      responses: [
        'Hi, How can I help you?',
        'I\'m QBot, I\'m here to answer your questions about this app.',
        'You are welcome.',
      ],
      // Optional arguments
      bgColor: Colors.black87,
      txtFiledDecoration: InputDecoration(
        hintText: 'Type / for suggestions.',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      sendIcon: Icon(Icons.send_rounded, color: Colors.blue),
      msgStyle: TextStyle(color: Colors.white),
      divider: SizedBox(),
      typing: SizedBox(
        height: 50,
        width: 50,
        child: Lottie.asset('assets/typing.json'),
      ),
      delay: 2,
      msgTime: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Text(
          DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
```

Then just use it like this:
```dart
QBot(config: config)
```

## Testing

To run the tests for this package, use:

```bash
flutter test
```

This will run all the unit tests to ensure everything is working correctly.

## License
This package is open source and available under the MIT License.

## Contributions
Feel free to open an issue or pull request if you find a bug or want to add a new feature! Contributions are always welcome.
