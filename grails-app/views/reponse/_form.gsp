<%@ page import="interacquizz.Reponse" %>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'intitule', 'error')} control-group ">
	<label for="intitule" class="control-label">
		<g:message code="reponse.intitule.label" default="Intitule" />
	</label>
	<div class="controls">
		<g:textField class="span10" name="intitule" value="${reponseInstance?.intitule}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'commentaire', 'error')} control-group ">
	<label for="commentaire" class="control-label">
		<g:message code="reponse.commentaire.label" default="Commentaire" />
		
	</label>
	<div class="controls">
	<g:textArea name="commentaire" class="span10" value="${reponseInstance?.commentaire}"/>
	</div>
</div>

<g:hiddenField name="session.id" value="${ (reponseInstance?.sessionRep?.id)?reponseInstance?.sessionRep?.id:params.sessionReponse?.id }"/>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'valide', 'error')} control-group ">
	<label for="valide" class="control-label">
		<g:message code="reponse.valide.label" default="Valide" />
		
	</label>
	<div class="controls">
	<g:checkBox name="valide" value="${reponseInstance?.valide}" />
	</div>
</div>


<g:hiddenField name="vote" type="number" value="${reponseInstance.vote}" required=""/>


