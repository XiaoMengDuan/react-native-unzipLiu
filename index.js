import React, { NativeModules } from 'react-native';

const UnzipLiu = NativeModules.UnzipLiu;

export const unGzip = (source, target) => {
  return UnzipLiu.unGzip(source, target);
};

export const unZipFile = (srcFilePath, destFilePath) => {
  return UnzipLiu.unZipFile(srcFilePath, destFilePath);
}

export const zipFiles = (srcFilePaths, destFilePath) => {
  return UnzipLiu.zipFiles(srcFilePaths, destFilePath);
}

export const dismissKeyboard = () => {
  return UnzipLiu.dismissKeyboardWithResolver();
}