
<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Ajouter une reponse</title>
	</head>
	<body>
		<div class="span12"></div>
		<g:form controller="reponse" action="ajout" class="well span6 offset3" >
			<g:hiddenField name="idSessionReponse" value="${sessionReponseInstance?.id}" />
			<fieldset>
				<legend>${sessionReponseInstance.getQuestion() }</legend>
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
		<div class="span6 offset3">
			<g:link class="btn btn-large pull-right">Passer au vote</g:link>
		</div>
	</body>
</html>
