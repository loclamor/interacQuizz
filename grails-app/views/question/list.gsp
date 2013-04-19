
<%@ page import="interacquizz.Question"%>
<%@ page import="interacquizz.SessionReponse"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'question.label', default: 'Question')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div id="list-question" class="well span8 offset2" role="main">
		<fieldset>
			<legend>
				Liste de vos questions
				<g:link action="create" class="btn pull-right">
					<i class="icon-plus"></i>
				</g:link>
			</legend>
			<g:if test="${flash.message}">
				<div class="alert alert-info" role="status">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					${flash.message}
				</div>
			</g:if>
			<table class="table table-striped">
				<thead>
					<tr>
						<g:sortableColumn property="intitule"
							title="${message(code: 'question.intitule.label', default: 'Intitule')}" />

						<g:sortableColumn property="commentaire"
							title="${message(code: 'question.commentaire.label', default: 'Commentaire')}" />

						<th>Nombre de sessions</th>

					</tr>
				</thead>
				<tbody>
					<g:each in="${questionInstanceList}" status="i"
						var="questionInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td>
								${fieldValue(bean: questionInstance, field: "intitule")}
							</td>

							<td><g:link action="show" id="${questionInstance.id}">
									${fieldValue(bean: questionInstance, field: "commentaire")}
								</g:link></td>

							<td>
								${ questionInstance.sessions.size() }
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${questionInstanceTotal}" />
			</div>
		</fieldset>
	</div>
</body>
</html>
