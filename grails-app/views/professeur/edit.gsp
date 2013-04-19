<%@ page import="interacquizz.Professeur"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title>InteracQuizz - Edition de votre profil</title>
</head>
<body>
	<div id="edit-professeur" class="content scaffold-edit" role="main">
		<g:form method="post" class="well span6 offset3 form-horizontal">
			<fieldset>
				<legend>Edition de votre profil</legend>
				<g:if test="${flash.message}">
					<div class="alert alert-error" role="status">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
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

				<g:hiddenField name="id" value="${professeurInstance?.id}" />
				<g:hiddenField name="version" value="${professeurInstance?.version}" />

				<g:render template="form" />

				<div class="control-group">
					<div class="controls">
						<g:actionSubmit class="btn btn-large span4 offset6"
							action="update" value="Enregistrer" />
					</div>
				</div>
			</fieldset>
		</g:form>
	</div>
</body>
</html>
