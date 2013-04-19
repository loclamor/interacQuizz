<%@ page import="interacquizz.Question"%>


<div
	class="fieldcontain ${hasErrors(bean: questionInstance, field: 'intitule', 'error')} control-group ">
	<label for="intitule" class="control-label"> <g:message
			code="question.intitule.label" default="Intitule" />

	</label>
	<div class="controls">
		<g:textField name="intitule" class="span10" value="${questionInstance?.intitule}" required=""/>
	</div>
</div>


<div
	class="fieldcontain ${hasErrors(bean: questionInstance, field: 'commentaire', 'error')} control-group ">
	<label for="commentaire" class="control-label"> <g:message
			code="question.commentaire.label" default="Commentaire" />

	</label>
	<div class="controls">
		<g:textArea name="commentaire" class="span10"
			value="${questionInstance?.commentaire}" />
	</div>
</div>

<div
	class="fieldcontain ${hasErrors(bean: questionInstance, field: 'createur', 'error')} ">
	<div class="controls">
		<g:hiddenField name="createur.id"
			value="${session.prof.getId()}"  />
	</div>
</div>




