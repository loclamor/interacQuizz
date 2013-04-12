<%@ page import="interacquizz.Professeur" %>



<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'identifiant', 'error')} ">
	<label for="identifiant">
		<g:message code="professeur.identifiant.label" default="Identifiant" />
		
	</label>
	<g:textField name="identifiant" value="${professeurInstance?.identifiant}" required="" />
</div>

<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'motDePasse', 'error')} ">
	<label for="motDePasse">
		<g:message code="professeur.motDePasse.label" default="Mot De Passe" />
		
	</label>
	<g:textField name="motDePasse" value="${professeurInstance?.motDePasse}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'nom', 'error')} ">
	<label for="nom">
		<g:message code="professeur.nom.label" default="Nom" />
		
	</label>
	<g:textField name="nom" value="${professeurInstance?.nom}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: professeurInstance, field: 'prenom', 'error')} ">
	<label for="prenom">
		<g:message code="professeur.prenom.label" default="Prenom" />
		
	</label>
	<g:textField name="prenom" value="${professeurInstance?.prenom}" required=""/>
</div>

