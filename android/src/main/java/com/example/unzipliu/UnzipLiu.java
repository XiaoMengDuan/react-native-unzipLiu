package com.example.unzipliu;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.zip.GZIPInputStream;

public class UnzipLiu extends ReactContextBaseJavaModule {


    public UnzipLiu(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "UnzipLiu";
    }

    /**
     * 压缩文件
     */
    @ReactMethod
    public void zipFiles(final String[] srcFilePaths, final String destFilePath, final Promise promise) {

        new Thread(new Runnable() {
            @Override
            public void run() {

                boolean isSuccess = ZipHelper.zipFiles(srcFilePaths, destFilePath);

                if (isSuccess) {
                    promise.resolve(1);
                } else {
                    promise.reject("-3", "Couldn't open file " + srcFilePaths + ". ");
                }

            }
        }).start();

    }


    /**
     * 解压文件
     */
    @ReactMethod
    public void unZipFile(final String srcFilePath, final String destFilePath, final Promise promise) {

        new Thread(new Runnable() {
            @Override
            public void run() {

                boolean isSuccess = ZipHelper.unZipFile(srcFilePath, destFilePath);

                if (isSuccess) {
                    promise.resolve(1);
                } else {
                    promise.reject("-2", "Couldn't open file " + srcFilePath + ". ");
                }

            }
        }).start();
    }


    @ReactMethod
    public void unGzip(final String srcFilePath, final String destFilePath, final Promise promise) {
        new Thread(new Runnable() {
            @Override
            public void run() {

                try {
                    File srcFile = new File(srcFilePath);
                    File destFile = new File(destFilePath);

                    String path = destFile.getParentFile().getPath();

                    File destFilePath = new File(path);

                    if (!destFilePath.exists()) {
                        destFilePath.mkdirs();
                    }

                    if (!destFile.exists()) {
                        destFile.createNewFile();
                    }

                    FileInputStream fIS = new FileInputStream(srcFile);
                    GZIPInputStream gzipIS = new GZIPInputStream(fIS);
                    FileOutputStream fOS = new FileOutputStream(destFile);

                    byte[] buff = new byte[1024];
                    int len = -1;

                    while ((len = gzipIS.read(buff)) != -1) {
                        fOS.write(buff, 0, len);
                    }
                    fOS.flush();
                    fOS.close();

                    gzipIS.close();
                    fIS.close();

                    promise.resolve(1);

                } catch (Exception e) {
                    e.printStackTrace();

                    promise.reject("-1", "Couldn't open file " + srcFilePath + ". ");

                }

            }
        }).start();
    }

}
