<%@ page import = "java.sql.*" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "javax.sql.DataSource" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "org.springframework.web.context.support.WebApplicationContextUtils,org.springframework.web.context.WebApplicationContext" %>
<%@ page import = "com.ibatis.sqlmap.client.SqlMapClient,java.sql.Connection" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "com.google.android.gcm.server.*" %>
<%@ page import="javapns.back.PushNotificationManager" %>
<%@ page import="javapns.back.SSLConnectionHelper" %>
<%@ page import="javapns.data.Device" %>
<%@ page import="javapns.data.PayLoad" %>
<%@ page import="java.lang.Object" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%!
  public static String cutStr(String str,int cutByte)
  {
    byte [] strByte = str.getBytes();
    if( strByte.length < cutByte )
      return str;
    int cnt = 0;
    for( int i = 0; i < cutByte; i++ )
    {
      if( strByte[i] < 0 )
        cnt++;
    }

    String r_str;
    if(cnt%2==0) r_str = new String(strByte, 0, cutByte );
    else r_str = new String(strByte, 0, cutByte + 1 );

    return r_str;
  }
%>
<%
  ArrayList<String> regid = new ArrayList<String>();	//메시지를 보낼 대상들
  String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);	//메시지 고유 ID
  boolean SHOW_ON_IDLE = false;	//기기가 활성화 상태일때 보여줄것인지
  int LIVE_TIME = 1;	//기기가 비활성화 상태일때 GCM가 메시지를 유효화하는 시간
  int RETRY = 2;	//메시지 전송실패시 재시도 횟수
  String simpleApiKey = "AIzaSyB2HDyz45i4_3ElFpqb1ko-u5FHsfExUOA";	//가이드 1때 받은 키
  String gcmURL = "https://android.googleapis.com/gcm/send";		//푸쉬를 요청할 구글 주소

  StringBuffer query = new StringBuffer();
  String bbsId = "";
  String msgData = "";
  String titData = "";
  String strWhere = "";

  String	idx				= "";
  String	title			= "";
  String	isPush			= "";
  String	actType			= "";
  String	category		= "";
  String	returnString	= "";
  String	categoryName	= "";

  //ios
  String host = "gateway.sandbox.push.apple.com";
  int port = 2195;
  String certificatePath = "/mobile_data/www/cms/WEB-INF/license/busan_cert.p12";     // 개발용
  //String certificatePath = "/mobile_data/www/cms/WEB-INF/license/product_busan_cert.p12"; //배포용
  String certificatePassword = "zaq1xsw2";                                 // 인증서 암호
  List<String> tokens = new ArrayList<String>();


  if(request.getParameter("idx")==null) {} else { idx = request.getParameter("idx"); }
  if(request.getParameter("title")==null) {} else { title = request.getParameter("title"); }
  if(request.getParameter("isPush")==null) {} else { isPush = request.getParameter("isPush"); }
  if(request.getParameter("actType")==null) {} else { actType = request.getParameter("actType"); }
  if(request.getParameter("category")==null) {} else { category = request.getParameter("category"); }
  if(request.getParameter("categoryName")==null) {} else { categoryName = request.getParameter("categoryName"); }
  categoryName = "[log4j.properties]";
  title = "테스트";



  String 	SrcQuery	= "";
  int 	check 		= 0;
  int		errorCode	= 0;
  int		strstate	= 0;


  regid.add("APA91bF5bGvv4zHJDrtmPguSyyAjXzGPJKStv5annIXlI0B65KEvQJpFC6zbeAQY_uZ90AiJmlpeqfrxKn4CYCgdNlLrX2o1G78zKPr_ZSTFp0ODOePLKN0702l1cRIKzDm5DWkXSes-9wWZvojBWDqX5b_cvgyhyFFZufmwdq75Yf1OIFCHYao");

  if(regid==null || regid.toString().replace("[]", "").trim().length() == 0 ){
    out.println("empty");
  }else{
    Sender sender = new Sender(simpleApiKey);
    Message message = new Message.Builder()
            .collapseKey(MESSAGE_ID)
            .delayWhileIdle(SHOW_ON_IDLE)
            .timeToLive(LIVE_TIME)
            .addData("title",URLEncoder.encode(categoryName,"UTF-8"))
            .addData("message",URLEncoder.encode(title,"UTF-8"))
            .addData("idx","47")
            .build();

    try {
      MulticastResult result = sender.send(message,regid,RETRY);
    } catch (Exception e) {
      out.println(e.toString());
    }
  }
  tokens.add("4b3a310b 8ea72fdb 5cd0eba1 25a9bfd0 84503191 ac3fb8b7 6b568fba fc8a2f7e");

  PayLoad payLoad = new PayLoad();
  payLoad.addAlert(cutStr(title,80));
  payLoad.addCustomDictionary("title", categoryName);
  payLoad.addCustomDictionary("idx", "47");
  payLoad.addBadge(1);
  payLoad.addSound("default");
  PushNotificationManager pushManager = PushNotificationManager.getInstance();
  for (int i = 0; i < tokens.size(); i++) {
    String deviceId = "phone"+i;
    pushManager.addDevice(deviceId,tokens.get(i).toString());
    Device client = pushManager.getDevice(deviceId);
    pushManager.initializeConnection(host, port, certificatePath, certificatePassword, SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
    pushManager.sendNotification(client, payLoad);
    pushManager.stopConnection();
    pushManager.removeDevice(deviceId);
  }
%>