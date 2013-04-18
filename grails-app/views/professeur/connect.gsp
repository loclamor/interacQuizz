<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Identification Professeur</title>
	</head>
	<body>
		<g:form controller="professeur" action="connexion" class="well span6 offset3 form-horizontal" >
			<fieldset>
				<legend>Identification Professeur</legend>
				<div class="control-group">
					<label class="control-label" for="identifiant">Identifiant</label>
    				<div class="controls">
      						<g:textField name="identifiant" class="span10" placeholder="identifiant" required="" />
    				</div>
    			</div>
				<div class="control-group">
					<label class="control-label" for="motDePasse">Mot de Passe</label>
    				<div class="controls">
      						<g:textField name="motDePasse" type="password" class="span10" placeholder="mot de passe" required="" />
    				</div>
    			</div>
    			<div class="control-group">
    				<div class="controls">
    					<g:submitButton name="envoyer" value="Envoyer" class="btn btn-large offset6 span4" />
    				</div>
    			</div>
			</fieldset>
		</g:form>
	</body>
</html>
