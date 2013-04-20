<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sessionReponse.label', default: 'SessionReponse')}" />
		<title>InteracQuizz - Editer une Session</title>
	</head>
	<body>
		<div id="edit-sessionReponse" class="content scaffold-edit" role="main">
			<g:form method="post" class="well span8 offset2 form-horizontal">
			<fieldset>
				<legend>${ sessionReponseInstance?.question }
				 : Editer une Session</legend>
				<g:if test="${flash.message}">
					<div class="alert alert-error" role="status">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						${flash.message}
					</div>
				</g:if>
				<g:hasErrors bean="${sessionReponseInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${sessionReponseInstance}" var="error">
							<li
								<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
									error="${error}" /></li>
						</g:eachError>
					</ul>
				</g:hasErrors>
				
				<g:hiddenField name="id" value="${sessionReponseInstance?.id}" />
				<g:hiddenField name="version" value="${sessionReponseInstance?.version}" />
				
				<g:render template="form" />
				<div class="control-group">
					<div class="controls">
						<g:actionSubmit class="btn btn-large btn-danger offset4 span3" action="delete"
							value="Supprimer" formnovalidate=""
							onclick="return confirm('Vous allez supprimer une question.\nVoulez vous continuer ?');" />
						<g:actionSubmit class="btn btn-large span3 offset1" action="update"
							value="Enregistrer" />
					</div>
				</div>
			</fieldset>
			</g:form>
		</div>
	</body>
</html>
