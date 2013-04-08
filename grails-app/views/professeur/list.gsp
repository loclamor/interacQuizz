
<%@ page import="interacquizz.Professeur" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'professeur.label', default: 'Professeur')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-professeur" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-professeur" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="identifiant" title="${message(code: 'professeur.identifiant.label', default: 'Identifiant')}" />
					
						<g:sortableColumn property="motDePasse" title="${message(code: 'professeur.motDePasse.label', default: 'Mot De Passe')}" />
					
						<g:sortableColumn property="nom" title="${message(code: 'professeur.nom.label', default: 'Nom')}" />
					
						<g:sortableColumn property="prenom" title="${message(code: 'professeur.prenom.label', default: 'Prenom')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${professeurInstanceList}" status="i" var="professeurInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${professeurInstance.id}">${fieldValue(bean: professeurInstance, field: "identifiant")}</g:link></td>
					
						<td>${fieldValue(bean: professeurInstance, field: "motDePasse")}</td>
					
						<td>${fieldValue(bean: professeurInstance, field: "nom")}</td>
					
						<td>${fieldValue(bean: professeurInstance, field: "prenom")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${professeurInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
