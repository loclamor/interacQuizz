<%@ page import="interacquizz.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'commentaire', 'error')} ">
	<label for="commentaire">
		<g:message code="question.commentaire.label" default="Commentaire" />
		
	</label>
	<g:textField name="commentaire" value="${questionInstance?.commentaire}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'createur', 'error')} required">
	<label for="createur">
		<g:message code="question.createur.label" default="Createur" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="createur" name="createur.id" from="${interacquizz.Professeur.list()}" optionKey="id" required="" value="${questionInstance?.createur?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'intitule', 'error')} ">
	<label for="intitule">
		<g:message code="question.intitule.label" default="Intitule" />
		
	</label>
	<g:textField name="intitule" value="${questionInstance?.intitule}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'sessions', 'error')} ">
	<label for="sessions">
		<g:message code="question.sessions.label" default="Sessions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${questionInstance?.sessions?}" var="s">
    <li><g:link controller="sessionReponse" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="sessionReponse" action="create" params="['question.id': questionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sessionReponse.label', default: 'SessionReponse')])}</g:link>
</li>
</ul>

</div>

