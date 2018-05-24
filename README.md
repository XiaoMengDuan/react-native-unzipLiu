# React Native UnzipLiu [![npm](https://img.shields.io/npm/dm/react-native-unzipliu.svg)](https://www.npmjs.com/package/react-native-unzipliu) [![npm](https://img.shields.io/npm/v/react-native-unzipliu.svg)](https://www.npmjs.com/package/react-native-unzipliu)

Unzip for React Native App

This is for GZip file

Version 1.0.3 Add Zip and Unzip function

Version 1.0.7 remove keyboard in Version 1.0.6

## Installation

```bash
npm install react-native-unzipliu --save
react-native link react-native-unzipliu
```

## Usage

import it into your code

```js
import { unGzip } from 'react-native-unzipliu';
```

## API

**unGzip(source: string, target: string): Promise**

> unzip from source file to target file

Example

```js
const sourcePath = `${DocumentDirectoryPath}/myFile.zip`;
const targetPath = `${DocumentDirectoryPath}/myFile.txt`;

unGzip(sourcePath, targetPath)
.then((path) => {
  console.log(`unzip completed at ${path}`);
})
.catch((error) => {
  console.log(error);
});
```
