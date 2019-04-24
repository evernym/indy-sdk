package me.connect;

import com.sun.jna.*;

//import java.util.concurrent.CompletableFuture;
import java.util.Map;
import java.util.HashMap;

public class CallbackLogger {

  private Map<Integer, String> levelMappings;
  public Pointer context;
  public Callback enabled;
  public Callback log;
  public Callback flush;

  public CallbackLogger() {
    levelMappings = new HashMap<Integer, String>();
    levelMappings.put(1, "Error");
    levelMappings.put(2, "Warning");
    levelMappings.put(3, "Info");
    levelMappings.put(4, "Debug");
    levelMappings.put(5, "Trace");

    context = null;
    enabled = null;

  //   enabled = new Callback() {
  //     @SuppressWarnings({"unused", "unchecked"})
  //     public void callback() {

  // //        CompletableFuture<Void> future = (CompletableFuture<Void>) removeFuture(xcommand_handle);
  // //        if (!checkResult(future, err)) return;
  // //
  // //        Void result = null;
  // //        future.complete(result);
  //     }
  //   };

    log = new Callback() {
      @SuppressWarnings({"unused", "unchecked"})
      public void callback(Pointer context, int level, String target, String message, String modulePath, String file, int line) {
          System.out.println(levelMappings.get(level) + "    " + file + ":" + line + " | " + message);
  //        CompletableFuture<Void> future = (CompletableFuture<Void>) removeFuture(xcommand_handle);
  //        if (!checkResult(future, err)) return;
  //
  //        Void result = null;
  //        future.complete(result);
      }
    };

    flush = null;

  //   flush = new Callback() {
  //     @SuppressWarnings({"unused", "unchecked"})
  //     public void callback() {

  // //        CompletableFuture<Void> future = (CompletableFuture<Void>) removeFuture(xcommand_handle);
  // //        if (!checkResult(future, err)) return;
  // //
  // //        Void result = null;
  // //        future.complete(result);
  //     }
  //   };
  }

}