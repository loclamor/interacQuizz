<%@ page import="interacquizz.Question"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'question.label', default: 'Question')}" />
<title><g:message code="default.create.label"
		args="[entityName]" /></title>
</head>
<body>
	<div id="create-question" role="main">
		<g:form action="save" class="well span8 offset2 form-horizontal">
			<fieldset>
				<legend>Ajouter une nouvelle question</legend>
				<g:if test="${flash.message}">
					<div class="alert alert-error" role="status">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						${flash.message}
					</div>
				</g:if>
				<g:hasErrors bean="${questionInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${questionInstance}" var="error">
							<li
								<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
									error="${error}" /></li>
						</g:eachError>
					</ul>
				</g:hasErrors>
				<fieldset class="form">
					<g:render template="form" />
				</fieldset>
				<div class="control-group">
					<div class="controls">
						<g:submitButton name="create" class="btn btn-large offset8 span2"
							value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</div>
				</div>
			</fieldset>
		</g:form>
	</div>
</body>
</html>
