<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<title>InteracQuizz - Accueil</title>

</head>
<body>
	<div class="span12"></div>
	<g:form controller="sessionReponse" action="connect" class="well span6 offset3" >
		<fieldset>
			<legend >Accéder à une Question</legend>
			<div class="input-append row-fluid">
				<g:passwordField name="codeSession" class="span10" placeholder="Entrez le code secret..." required=""/>
				<button type="submit" name="submit_codeSession" class="btn btn-primary" >Valider</button>
			</div>
			<g:if test="${flash.messageErreur}">
				<div class="alert alert-error" role="status">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					${flash.messageErreur}
				</div>
			</g:if>
			<br>
			<span>
				Ou connectez vous avec votre 
				<g:link controller="professeur" action="connect">compte professeur</g:link>
			</span>
		</fieldset>
	</g:form>
</body>
</html>
