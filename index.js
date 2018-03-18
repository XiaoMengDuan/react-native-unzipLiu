import React, { NativeModules } from 'react-native';

const UnzipLiu = NativeModules.UnzipLiu;

export const unzip = (source, target) => {
  return UnzipLiu.unzip(source, target);
}