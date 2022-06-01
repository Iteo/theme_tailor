
# Theme Tailor



## Generate style classes from figma


## Example

TODO!

## How to do it

### 1. Prepare colors and font styles accordingly

You must create colors and fonts styles, you can learn how to do it from articale below

🔗 &nbsp;&nbsp;[(Click Me!) How create colors and fonts styles](https://help.figma.com/hc/en-us/articles/360038746534-Create-color-text-effect-and-layout-grid-styles)

</br>

### 2. Install and configure plugin for figma

🔗 &nbsp;&nbsp;[(Click Me!) Design Tokens](https://www.figma.com/community/plugin/888356646278934516/Design-Tokens)

When you have aready installed plugin go to `Plugins > Design Tokens > Settings` and you must changed some parameters.

* in `Filename` section change name to `style` and format from `.tokens.json` to `.json`.
* in `Name conversion` set type to `camelCase`.

Okey, now you can save changes and go to next step!

</br>

### 3. Export to json

- go to `Plugins > Design Tokens > Export Design Token File`
- in `Include types in export` section, check only `Colors` and `Font Styles` option.
- click `Save & Export` and save file to `styles` folder in your assets.

</br>

### 4. Generate the style classes

if you already have an exported color or font style file from figma, make sure it's in the folder `assets/styles` and use this command to generate the classes

```dart
  flutter pub run theme_tailor:main
```

| Args | Name     | Description                |
| :-------- | :------- | :------------------------- |
| `-h` | `help` | Showing all parameters |
| `-S` | `source-dir` | Folder containing styles files (defaults to "assets/styles") |
| `-T` | `source-file-typography` | File to use for typography style (defaults to "typography.json") |
| `-C` | `source-file-colors` | File to use for colors style (defaults to "colors.json") |
| `-O` | `output-dir` | Output folder stores for the generated file (defaults to "lib/presentation/style") |
| `-t` | `output-file-typography` | Output file name (defaults to "app_typography.dart") |
| `-c` | `output-file-colors` |  Output file name (defaults to "app_colors.dart") |

</br>

### 5. There it is, you can already use your styles!

```dart
  Container(
    color: AppColors.myCoolColor,
    child: Text(
      "YEAH!",
      style: AppTypography.myFontStyle
    ),
  ),
```