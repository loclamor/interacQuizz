<%@ page import="interacquizz.Reponse" %>



<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'commentaire', 'error')} ">
	<label for="commentaire">
		<g:message code="reponse.commentaire.label" default="Commentaire" />
		
	</label>
	<g:textField name="commentaire" value="${reponseInstance?.commentaire}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'intitule', 'error')} ">
	<label for="intitule">
		<g:message code="reponse.intitule.label" default="Intitule" />
		
	</label>
	<g:textField name="intitule" value="${reponseInstance?.intitule}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'session', 'error')} required">
	<label for="session">
		<g:message code="reponse.session.label" default="Session" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="session" name="session.id" from="${interacquizz.SessionReponse.list()}" optionKey="id" required="" value="${reponseInstance?.session?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'valide', 'error')} ">
	<label for="valide">
		<g:message code="reponse.valide.label" default="Valide" />
		
	</label>
	<g:checkBox name="valide" value="${reponseInstance?.valide}" />
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'vote', 'error')} required">
	<label for="vote">
		<g:message code="reponse.vote.label" default="Vote" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vote" type="number" value="${reponseInstance.vote}" required=""/>
</div>

