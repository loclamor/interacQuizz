
<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sessionReponse.label', default: 'SessionReponse')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-sessionReponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-sessionReponse" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="cleeAcces" title="${message(code: 'sessionReponse.cleeAcces.label', default: 'Clee Acces')}" />
					
						<g:sortableColumn property="cloture" title="${message(code: 'sessionReponse.cloture.label', default: 'Cloture')}" />
					
						<th><g:message code="sessionReponse.question.label" default="Question" /></th>
					
						<g:sortableColumn property="visible" title="${message(code: 'sessionReponse.visible.label', default: 'Visible')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sessionReponseInstanceList}" status="i" var="sessionReponseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sessionReponseInstance.id}">${fieldValue(bean: sessionReponseInstance, field: "cleeAcces")}</g:link></td>
					
						<td><g:formatBoolean boolean="${sessionReponseInstance.cloture}" /></td>
					
						<td>${fieldValue(bean: sessionReponseInstance, field: "question")}</td>
					
						<td><g:formatBoolean boolean="${sessionReponseInstance.visible}" /></td>
					
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
