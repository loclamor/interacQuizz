
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
			
			<g:if test="${ flash.voteEnCours }" >
				<div class="alert alert-info" role="status">
					<g:link controller="sessionReponse" action="phaseResultat" id="${ sessionReponseInstance.getId() }" class="btn pull-right">
						<i class="icon-refresh" ></i>
					</g:link>
					<h4>Le vote est en cours </h4>
					Merci de patienter...
				</div>
			</g:if>
			<g:else>
				<g:chart votes="${ votes }" />
			</g:else>
		</fieldset>
	</div>
     
    
</body>
</html>
