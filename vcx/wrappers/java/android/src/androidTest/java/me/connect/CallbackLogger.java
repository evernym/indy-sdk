package me.connect;

import com.sun.jna.*;

import java9.util.concurrent.CompletableFuture;

public class CallbackLogger {

  public Pointer context = null;

  public Callback enabled = new Callback() {
    @SuppressWarnings({"unused", "unchecked"})
    public void callback(int xcommand_handle, int err) {

//        CompletableFuture<Void> future = (CompletableFuture<Void>) removeFuture(xcommand_handle);
//        if (!checkResult(future, err)) return;
//
//        Void result = null;
//        future.complete(result);
    }
  };

  public Callback log = new Callback() {
    @SuppressWarnings({"unused", "unchecked"})
    public void callback(int xcommand_handle, int err) {

//        CompletableFuture<Void> future = (CompletableFuture<Void>) removeFuture(xcommand_handle);
//        if (!checkResult(future, err)) return;
//
//        Void result = null;
//        future.complete(result);
    }
  };

  public Callback flush = new Callback() {
    @SuppressWarnings({"unused", "unchecked"})
    public void callback(int xcommand_handle, int err) {

//        CompletableFuture<Void> future = (CompletableFuture<Void>) removeFuture(xcommand_handle);
//        if (!checkResult(future, err)) return;
//
//        Void result = null;
//        future.complete(result);
    }
  };


}