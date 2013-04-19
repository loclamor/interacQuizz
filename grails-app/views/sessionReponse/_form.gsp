<%@ page import="interacquizz.SessionReponse"%>



<div
	class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'phase', 'error')} control-group ">
	<label for="phase" class="control-label"> <g:message
			code="sessionReponse.phase.label" default="Phase" />

	</label>
	<div class="controls">
		<g:select name="phase" class="span10"
			from="${sessionReponseInstance.constraints.phase.inList}"
			value="${sessionReponseInstance?.phase}"
			valueMessagePrefix="sessionReponse.phase" noSelection="['': '']" />
	</div>
</div>

<div
	class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'cleeAcces', 'error')} control-group ">
	<label for="cleeAcces" class="control-label"> <g:message
			code="sessionReponse.cleeAcces.label" default="Clée d'Acces" />

	</label>
	<div class="controls">
		<g:passwordField name="cleeAcces" class="span10"
			value="${sessionReponseInstance?.cleeAcces}" />
	</div>
</div>

<div
	class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'question', 'error')} required control-group ">
	<label for="question" class="control-label"> <g:message
			code="sessionReponse.question.label" default="Question" />
	</label>
	<div class="controls">
		<g:select id="question" name="question.id" 
			from="${interacquizz.Question.list()}" optionKey="id" required=""
			value="${sessionReponseInstance?.question?.id}" class="many-to-one" class="span10"/>
	</div>
</div>

<div
	class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'reponses', 'error')} control-group ">
	<label for="reponses" class="control-label"> <g:message
			code="sessionReponse.reponses.label" default="Reponses" />
	</label>
	<div class="controls">
		<ul class="one-to-many">
			<g:each in="${sessionReponseInstance?.reponses?}" var="r">
				<li><g:link controller="reponse" action="show" id="${r.id}">
						${r?.encodeAsHTML()}
					</g:link></li>
			</g:each>
			<li class="add"><g:link controller="reponse" action="create"
					params="['sessionReponse.id': sessionReponseInstance?.id]">
					${message(code: 'default.add.label', args: [message(code: 'reponse.label', default: 'Reponse')])}
				</g:link></li>
		</ul>
	</div>
</div>

<div
	class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'visible', 'error')} control-group ">
	<label for="visible" class="control-label"> <g:message
			code="sessionReponse.visible.label" default="Visible" />

	</label>
	<div class="controls">
		<g:checkBox name="visible" value="${sessionReponseInstance?.visible}" />
	</div>
</div>

