package com.springapp.mvc.push;

import java.io.IOException;

import java.net.URLEncoder;
import java.util.ArrayList;

import java.util.List;


import com.google.android.gcm.server.Message;

import com.google.android.gcm.server.MulticastResult;

import com.google.android.gcm.server.Result;

import com.google.android.gcm.server.Sender;
import org.apache.log4j.Logger;

/**
 * Created by young on 2015-09-01.
 */
public class GCMServerSide {
    public String sendMessage(String regId2, String p12, String subject, String content) throws IOException {
        String results = "";
//        Sender sender = new Sender("AIzaSyAyWi2R0EnnJWLATD_V4PhKl4XUXnBt1lE");
        Sender sender = new Sender(p12);
//        String regId = "APA91bG9bu9guA57wc74R4khIYdz-DodwGbI_BX-pt7Oj9Y9_7vJz5lElhDehUKI4uawYTn8qhDa36dQ0YQNsCaOOhCMtX-1iaQQd1BHoPCn_h5AIMci-G9uM9YFu9-a-3z54MRO1Rxr"; // 안드로이드 즉 클라이언트에서 나온값
//        String regId2 = "APA91bFN7fdTxX6cv6jtpDBvXR3W9aJBOZvdnbLoWCFevBygzE7qxxmd8pf0LEJ_gUZaf66k4DEABAy0SAR38TJ_a5Mc8__aY7aEC3YYmKlpVzzbGE7DczISt4bNf9UWwBE0YiFyljBR"; // 안드로이드 즉 클라이언트에서 나온값
//        String regId2 = "1"; // 안드로이드 즉 클라이언트에서 나온값
        Message message = new Message.Builder().addData("title", URLEncoder.encode(subject, "UTF-8")).addData("message", URLEncoder.encode(content, "UTF-8")).build();

        List<String> list = new ArrayList<String>();

        list.add(regId2);


        MulticastResult multicastResult = sender.send(message, list, 5);



        if (multicastResult != null) {
            List<Result> resultList = multicastResult.getResults();

            for (Result result : resultList) {
                System.out.println("regId="+result.getMessageId());
                results = result.getMessageId();
            }
        }
        return results;
    }

//    public static void main(String[] args) throws Exception {
//        GCMServerSide s = new GCMServerSide();
//        s.sendMessage();
//    }
}
