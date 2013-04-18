
<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Ajouter une reponse</title>
	</head>
	<body>
		<div class="span12"></div>
		<g:form controller="reponse" action="ajout" class="well span8 offset2" >
			<g:hiddenField name="idSessionReponse" value="${sessionReponseInstance?.id}" />
			<fieldset>
				<legend>
					${sessionReponseInstance.getQuestion() }
					<g:link controller="sessionReponse" action="phaseVote" id="${sessionReponseInstance?.id}" class="btn pull-right">Vote <i class="icon-fast-forward"></i></g:link>
				</legend>
				<div class="input-append row-fluid">
					<g:textField name="nouvelleReponse" class="span10" placeholder="Entrez une proposition de reponse..." required="" />
					<button type="submit" name="submit_nouvelleReponse" class="btn btn-primary" >Ajouter</button>
				</div>
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
			</fieldset>
		</g:form>
	</body>
</html>
