
<%@ page import="interacquizz.Reponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reponse.label', default: 'Reponse')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-reponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-reponse" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="commentaire" title="${message(code: 'reponse.commentaire.label', default: 'Commentaire')}" />
					
						<g:sortableColumn property="intitule" title="${message(code: 'reponse.intitule.label', default: 'Intitule')}" />
					
						<th><g:message code="reponse.session.label" default="Session" /></th>
					
						<g:sortableColumn property="valide" title="${message(code: 'reponse.valide.label', default: 'Valide')}" />
					
						<g:sortableColumn property="vote" title="${message(code: 'reponse.vote.label', default: 'Vote')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${reponseInstanceList}" status="i" var="reponseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${reponseInstance.id}">${fieldValue(bean: reponseInstance, field: "commentaire")}</g:link></td>
					
						<td>${fieldValue(bean: reponseInstance, field: "intitule")}</td>
					
						<td>${fieldValue(bean: reponseInstance, field: "sessionRep")}</td>
					
						<td><g:formatBoolean boolean="${reponseInstance.valide}" /></td>
					
						<td>${fieldValue(bean: reponseInstance, field: "vote")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${reponseInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
