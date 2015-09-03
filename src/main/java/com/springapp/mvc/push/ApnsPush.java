package com.springapp.mvc.push;

import javapns.communication.exceptions.CommunicationException;
import javapns.communication.exceptions.KeystoreException;
import javapns.devices.Device;
import javapns.devices.exceptions.InvalidDeviceTokenFormatException;
import javapns.devices.implementations.basic.BasicDevice;
import javapns.notification.AppleNotificationServerBasicImpl;
import javapns.notification.PushNotificationManager;
import javapns.notification.PushNotificationPayload;
import javapns.notification.PushedNotification;
import org.apache.log4j.Logger;
import org.json.JSONException;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by young on 2015-09-02.
 */
public class ApnsPush {

    static Logger logger = Logger.getLogger(ApnsPush.class);
    public int sendMessage(String certificate,String password ,String token1,String content) throws KeystoreException, CommunicationException, JSONException, UnsupportedEncodingException {
        boolean singleSend = false;

//        String certificate = "C:/develop_gunsanAdd.p12"; // 인증서 파일경로
//        String password = "zaq1xsw2"; // 인증서 암호

//        String token1 = "9eb36fcd60c8b911a2d5c25191f77db7aa5dc4c14fc0e93e2636cf100b3ebad2"; // 토큰값
        System.out.println(token1.length());
        List<String> tokenList = new ArrayList<String>();

        tokenList.add(token1);

        PushNotificationManager pushManager = new PushNotificationManager();

        pushManager.initializeConnection(new AppleNotificationServerBasicImpl(certificate, password, false));
        PushNotificationPayload payload = PushNotificationPayload.complex();
        payload.addAlert(content);
        payload.addBadge(1);
        payload.addSound("default");

        List<PushedNotification> notifications = new ArrayList<PushedNotification>();
//
        if (singleSend){
            Device device = new BasicDevice();
            device.setToken(tokenList.get(0));
            PushedNotification notification = pushManager.sendNotification(device, payload);
            notifications.add(notification);
        }else{
            List<Device> device = new ArrayList<Device>();
            for (String token : tokenList){
                try {
                    device.add(new BasicDevice(token));
                } catch (InvalidDeviceTokenFormatException e) {
                    e.printStackTrace();
                }
            }
            notifications = pushManager.sendNotifications(payload, device);
        }
//
        List<PushedNotification> failedNotifications = PushedNotification.findFailedNotifications(notifications);
        List<PushedNotification> successfulNotifications = PushedNotification.findSuccessfulNotifications(notifications);
        int failed = failedNotifications.size();
        int successful = successfulNotifications.size();
        return successful;
    }
//    public static void main(String[] args) throws Exception {
//
//        BasicConfigurator.configure();

//        logger.debug("Hello log4j.");
//        logger.info("Hello log4j.");
//        logger.warn("Hello log4j.");
//        logger.error("Hello log4j.");
//        logger.fatal("Hello log4j.");
        //loger.log( Level.DEBUG , "debug") 와 동일하다.
//        ApnsPush aa = new ApnsPush();
//        aa.sendMessage();
//        System.out.println("file encoding : "
//                + System.getProperty("file.encoding"));
//    }
}
