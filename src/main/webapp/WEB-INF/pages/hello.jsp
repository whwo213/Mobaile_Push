<%--
  Created by IntelliJ IDEA.
  User: young
  Date: 2015-09-03
  Time: 오후 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<script src="/resources/js/jquery-1.11.3.js"></script>
<script src="/resources/js/jquery-1.11.3.min.js"></script>
<script src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap-theme.css">
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<%String regId = request.getParameter("regId") == null  ? "" : request.getParameter("regId");%>

<%if(regId.equals("")){%>
	<h1>${message}</h1>
	<form action="/pushForm" method="post" id="firstForm">
		<table border="1" width="50%" class="table">
			<tr>
				<td>OS</td>
				<td>
					<select name="osChoice" id="osChoice">
						<option value="">os</option>
						<option value="android">android</option>
						<option value="ios">ios</option>
					</select>
				</td>
			</tr>
			<tr style="display: none">
				<td>인증서선택</td>
				<td>
					<select name="p12" id="p12">
						<option value="">P12</option>
						<option value="gunsan">군산</option>
						<option value="jaeju">제주</option>
					</select>
				</td>
			</tr>
			<tr style="display: none">
				<td>인증서 암호</td>
				<td>
					<input type="text" name="iosPass" id="iosPass" placeholder="인증서 암호 입력" style="width: 80%" class="form-control"/>
				</td>
			</tr>
			<tr>
				<td>RegId</td>
				<td>
					<input type="text" name="regId" placeholder="RegId 입력" style="width: 80%" class="form-control" />
				</td>
			</tr>
			<tr style="display: none">
				<td>title</td>
				<td>
					<input type="text" name="subject" id="subject" placeholder="제목입력" class="form-control" />
				</td>
			</tr>
			<tr style="display: none">
				<td>content</td>
				<td>
					<input type="text" name="content" id="content" placeholder="내용" class="form-control" />
				</td>
			</tr>
			<tr align="right" >
				<td colspan="2" >
					<input type="submit" value="submit" class="btn btn-default"/>
				</td>
			</tr>
		</table>
	</form>
<%}else{%>
<%}%>
</body>
</html>

<script type="text/javascript">
	$(document).ready(function(){
		var osVal = '';
		var p12 = '';
		$('#osChoice').change(function(){
			osVal = $(this).val();
			if(osVal == 'ios'){
				$('#subject').parent().parent().hide();
				$('#p12').parent().parent().show();
				$('#iosPass').parent().parent().show();
				$('#content').parent().parent().show();
			}else{
				$('#p12').parent().parent().show();
				$('#iosPass').parent().parent().hide();
				$('#subject').parent().parent().show();
				$('#content').parent().parent().show();
			}
		})

		$('#p12').change(function(){
			p12 = $(this).val();
		})
		$('#firstForm').submit(function(){
			if(osVal == ''){
				alert('OS 선택해주세요');
				return false;
			}
			if($('#p12').parent().parent().css('display') != 'none'){
				if(p12 == ''){
					alert('인증서를 선택해주세요');
					return false;
				}
			}
			return true;
		})
	});
</script>