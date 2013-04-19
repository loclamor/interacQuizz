<%@ page import="interacquizz.Professeur"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'professeur.label', default: 'Professeur')}" />
<title>Inscription Professeur</title>
</head>
<body>
	<div id="create-professeur" class="content scaffold-create" role="main">
		<g:form action="save" class="well span6 offset3 form-horizontal">
			<fieldset class="form">
				<legend>Inscription Professeur</legend>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<g:hasErrors bean="${professeurInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${professeurInstance}" var="error">
							<li
								<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
									error="${error}" /></li>
						</g:eachError>
					</ul>
				</g:hasErrors>
				<g:render template="form" />
				<div class="control-group">
					<div class="controls">
						<g:submitButton name="create" class="btn btn-large offset6 span4"
							value="S'inscrire" />
					</div>
				</div>
			</fieldset>
		</g:form>
	</div>
</body>
</html>
