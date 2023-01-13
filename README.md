# fluffy-guide
First pass of application created from the codelabs tutorial [here](https://codelabs.developers.google.com/codelabs/flutter-codelab-first#8)

# Running
## From terimanl
1. cd ./<rotten>
2. `flutter run -d web-server` on terminal
3. Go to http://localhost:57000 on browser
4. `r` to reload recent changes on terminal

## From vscode debug
1. Install chrome [dart debug](https://chrome.google.com/webstore/detail/dart-debug-extension/eljbmlghnomdjgdjmbdekegdkbabckhm/related?hl=en) extension
2. Add `launch.json` in the folder `.vscode`
3. Add the json below.
    ```JSON
    {
       "version": "0.2.0",
        "configurations": [
            {
                "name": "rotten-webserver",
                "cwd": "rotten",
                "request": "launch",
                "type": "dart",
                "flutterMode": "debug",
                "deviceId": "web-server"
            }
        ]
    }
    ```
4. press f5
5. if it hasn't on its own go to `http://localhost:57748/#/`
6. press the dart extension on chrome instance