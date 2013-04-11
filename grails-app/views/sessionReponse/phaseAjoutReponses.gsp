
<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Ajouter une reponse</title>
	</head>
	<body>
		<g:form controller="reponse" action="ajout" class="well span6 offset3" >
			<g:hiddenField name="idSessionReponse" value="${sessionReponseInstance?.id}" />
			<fieldset>
				<legend>${sessionReponseInstance.getQuestion() }</legend>
				<div class="input-append row-fluid">
					<g:textField name="nouvelleReponse" class="span10" placeholder="Entrez une proposition de reponse..." required="" />
					<button type="submit" name="submit_nouvelleReponse" class="btn btn-primary" >Ajouter</button>
				</div>
			</fieldset>
		</g:form>
	</body>
</html>
