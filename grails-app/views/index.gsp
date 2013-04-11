<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<title>InteracQuizz - Accueil</title>

</head>
<body>
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<g:form controller="sessionReponse" action="connect" class="well span6 offset3" >
		<fieldset>
			<legend >Accéder à une Question</legend>
			<div class="input-append">
				<g:textField type="password" name="codeSession" class="" placeholder="Entrez le code secret..."/>
				<button type="submit" name="submit_codeSession" class="btn btn-primary" >Valider</button>
			</div>
			<br>
			<span>
				Ou connectez vous avec votre 
				<g:link controller="professeur" action="connect">compte professeur</g:link>
			</span>
		</fieldset>
	</g:form>

	<h2>Available Controllers:</h2>
	<ul>
		<g:each var="c"
			in="${grailsApplication.controllerClasses.sort { it.fullName } }">
			<li class="controller">
				<g:link controller="${c.logicalPropertyName}">
					${c.fullName}
				</g:link>
			</li>
		</g:each>
	</ul>
</body>
</html>
