
<%@ page import="interacquizz.SessionReponse"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'sessionReponse.label', default: 'SessionReponse')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div id="list-sessionReponse" class="well span8 offset2" role="main">
		<legend>${ questionInstance }
			 : Liste de vos sessions
			<g:link action="create" id="${ questionInstance.id }" class="btn pull-right">
				<i class="icon-plus"></i>
			</g:link>
		</legend>
		<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">
				${flash.message}
			</div>
		</g:if>
		<table class="table table-striped">
			<thead>
				<tr>
					<g:sortableColumn property="nom"
						title="${message(code: 'sessionReponse.nom.label', default: 'Nom')}" />

					<g:sortableColumn property="phase"
						title="${message(code: 'sessionReponse.phase.label', default: 'Phase')}" />

					<g:sortableColumn property="cleeAcces"
						title="${message(code: 'sessionReponse.cleeAcces.label', default: 'Clée d\'Acces')}" />

					<g:sortableColumn property="visible"
						title="${message(code: 'sessionReponse.visible.label', default: 'Visible')}" />

					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${sessionReponseInstanceList}" status="i"
					var="sessionReponseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>
							<g:link controller="sessionReponse" action="show" id="${ sessionReponseInstance.id }" >
								${fieldValue(bean: sessionReponseInstance, field: "nom")}
							</g:link>
						</td>
						
						<td>
							<g:link controller="sessionReponse" action="show" id="${ sessionReponseInstance.id }" >
								${fieldValue(bean: sessionReponseInstance, field: "phase")}
							</g:link>
						</td>

						<td>
							${fieldValue(bean: sessionReponseInstance, field: "cleeAcces")}
						</td>

						<td><g:formatBoolean
								boolean="${sessionReponseInstance.visible}" /></td>

						<td><g:link action="edit" id="${ sessionReponseInstance.getId() }"
								class="btn">
								<i class="icon-pencil"></i>
							</g:link></td>

					</tr>
				</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<g:paginate total="${sessionReponseInstanceTotal}" />
		</div>
	</div>
</body>
</html>
