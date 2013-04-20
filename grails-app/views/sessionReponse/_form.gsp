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


<g:hiddenField name="question.id" value="${sessionReponseInstance?.question?.id}"/>
<g:if test="${ sessionReponseInstance.getVersion() }">
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

			</ul>


			<g:link controller="reponse" action="create" class="btn"
				params="['sessionReponse.id': sessionReponseInstance?.id]">
				<i class="icon-plus"></i> Ajouter une reponse
			</g:link>

		</div>
	</div>
</g:if>
<div
	class="fieldcontain ${hasErrors(bean: sessionReponseInstance, field: 'visible', 'error')} control-group ">
	<label for="visible" class="control-label"> <g:message
			code="sessionReponse.visible.label" default="Visible" />

	</label>
	<div class="controls">
		<g:checkBox name="visible" value="${sessionReponseInstance?.visible}" />
	</div>
</div>

