package com.jiangyonghao.recycleview.nanshuibeidiao.apption;


import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Thread.UncaughtExceptionHandler;
import java.text.SimpleDateFormat;

public class MyCrashHandler implements UncaughtExceptionHandler{
    private static MyCrashHandler crashHandler;
    private SimpleDateFormat format = new SimpleDateFormat(
            "yyyy年MM月dd日 HH时mm分ss秒");// 用于格式化日期,作为日志文件名的一部分
    @Override
    public void uncaughtException(Thread thread, Throwable ex) {
        // TODO Auto-generated method stub
        if (crashHandler != null) {
            try {
                StringBuffer sb = new StringBuffer();
                sb.append("崩溃时间 ="+format.format(System.currentTimeMillis())+"\r\n");
                //将crash log写入文件
                File file = new File(Untils.SDpath+"carsh");
                if (!file.exists()) {// 目 录存在返回false
                    file.mkdirs();// 创建一个目录
                }

                FileWriter fileOutputStream = new FileWriter(Untils.SDpath+"carsh"+"/崩溃log.txt", true);
                fileOutputStream.write(sb.toString());
//                FileOutputStream fileOutputStream = new FileOutputStream("/mnt/sdcard/crash_log.txt", true);
                PrintWriter printStream = new PrintWriter(fileOutputStream);
//                ex.printStackTrace(err)
//                System.out.println(ex.z);
                ex.printStackTrace(printStream);
                printStream.flush();
                printStream.close();
                fileOutputStream.close();
//                System.exit(1);
            } catch (FileNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    //设置默认处理器
    public void init() {
        Thread.setDefaultUncaughtExceptionHandler(this);
    }

    private MyCrashHandler() {}
    //单例
    public static MyCrashHandler instance() {
        if (crashHandler == null) {
//            synchronized (crashHandler) {
            crashHandler = new MyCrashHandler();
//            }
        }
        return crashHandler;
    }
}
