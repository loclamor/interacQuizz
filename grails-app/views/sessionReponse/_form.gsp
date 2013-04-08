<%@ page import="interacquizz.SessionReponse" %>



<div class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'cleeAcces', 'error')} ">
	<label for="cleeAcces">
		<g:message code="sessionReponse.cleeAcces.label" default="Clee Acces" />
		
	</label>
	<g:textField name="cleeAcces" value="${sessionReponseInstance?.cleeAcces}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'cloture', 'error')} ">
	<label for="cloture">
		<g:message code="sessionReponse.cloture.label" default="Cloture" />
		
	</label>
	<g:checkBox name="cloture" value="${sessionReponseInstance?.cloture}" />
</div>

<div class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="sessionReponse.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="question" name="question.id" from="${interacquizz.Question.list()}" optionKey="id" required="" value="${sessionReponseInstance?.question?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'reponses', 'error')} ">
	<label for="reponses">
		<g:message code="sessionReponse.reponses.label" default="Reponses" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${sessionReponseInstance?.reponses?}" var="r">
    <li><g:link controller="reponse" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="reponse" action="create" params="['sessionReponse.id': sessionReponseInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'reponse.label', default: 'Reponse')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'visible', 'error')} ">
	<label for="visible">
		<g:message code="sessionReponse.visible.label" default="Visible" />
		
	</label>
	<g:checkBox name="visible" value="${sessionReponseInstance?.visible}" />
</div>

