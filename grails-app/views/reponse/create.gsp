<%@ page import="interacquizz.Reponse"%>
<%@ page import="interacquizz.SessionReponse"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title>InteracQuizz - Nouvelle reponse</title>
</head>
<body>

	<div id="create-reponse" class="content scaffold-create" role="main">
		<g:form action="save" class="well span8 offset2 form-horizontal">
			<fieldset>
				<legend>
					${ SessionReponse.get(params.sessionReponse?.id)?.getQuestion() }
					: Nouvelle reponse
				</legend>
				<g:if test="${flash.message}">
					<div class="alert alert-error" role="status">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						${flash.message}
					</div>
				</g:if>
				<g:hasErrors bean="${reponseInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${reponseInstance}" var="error">
							<li
								<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
									error="${error}" /></li>
						</g:eachError>
					</ul>
				</g:hasErrors>


				<g:render template="form" />

				<div class="control-group">
					<div class="controls">
						<g:submitButton name="create" class="btn offset7 span3 btn-large" value="Enregistrer" />
					</div>
				</div>
			</fieldset>
		</g:form>
	</div>
</body>
</html>
