<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<title>InteracQuizz - Accueil</title>

</head>
<body>
	
	<g:form controller="sessionReponse" action="connect" class="well span6 offset3" >
		<fieldset>
			<legend >Accéder à une Question</legend>
			<div class="input-append row-fluid">
				<g:passwordField name="codeSession" class="span10" placeholder="Entrez le code secret..." required=""/>
				<button type="submit" name="submit_codeSession" class="btn btn-primary" >Valider</button>
			</div>
			<g:if test="${flash.message}">
				<div class="alert alert-error" role="status">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					${flash.message}
				</div>
			</g:if>
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
