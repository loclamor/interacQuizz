<%@ page import="interacquizz.Professeur" %>



<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'identifiant', 'error')}  control-group">
	<label for="identifiant" class="control-label">
		<g:message code="professeur.identifiant.label" default="Identifiant" />
	</label>
	<div class="controls">
		<g:textField name="identifiant" class="span10" value="${professeurInstance?.identifiant}" required="" />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'motDePasse', 'error')}  control-group">
	<label for="motDePasse" class="control-label">
		<g:message code="professeur.motDePasse.label" default="Mot De Passe" />
		
	</label>
	<div class="controls">
		<g:textField name="motDePasse" class="span10" value="${professeurInstance?.motDePasse}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'nom', 'error')}  control-group">
	<label for="nom" class="control-label">
		<g:message code="professeur.nom.label" default="Nom" />
		
	</label>
	<div class="controls">
		<g:textField name="nom"  class="span10" value="${professeurInstance?.nom}" required=""/>
		</div>
</div>

<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'prenom', 'error')}  control-group">
	<label for="prenom" class="control-label">
		<g:message code="professeur.prenom.label" default="Prenom" />
		
	</label>
	<div class="controls">
		<g:textField name="prenom" class="span10" value="${professeurInstance?.prenom}" required=""/>
	</div>
</div>

