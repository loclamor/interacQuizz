
<%@ page import="interacquizz.SessionReponse"%>
<%@ page import="interacquizz.Reponse"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title>InteracQuizz - Vote</title>
</head>
<body>
	<div class="span12"></div>
	<div class="well span8 offset2">
		<fieldset>
			<legend>
				${ sessionReponseInstance.getQuestion() }
				<span class="muted pull-right"> Résultats du vote </span>
			</legend>
			<g:if test="${flash.messageErreur}">
				<div class="alert alert-error" role="status">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					${flash.messageErreur}
				</div>
			</g:if>
			<g:if test="${flash.messageInfo}">
				<div class="alert alert-info" role="status">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					${flash.messageInfo}
				</div>
			</g:if>

			<g:chart votes="${ votes }"></g:chart>

		</fieldset>
	</div>
</body>
</html>
