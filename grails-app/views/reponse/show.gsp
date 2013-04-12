
<%@ page import="interacquizz.Reponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reponse.label', default: 'Reponse')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-reponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-reponse" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list reponse">
			
				<g:if test="${reponseInstance?.commentaire}">
				<li class="fieldcontain">
					<span id="commentaire-label" class="property-label"><g:message code="reponse.commentaire.label" default="Commentaire" /></span>
					
						<span class="property-value" aria-labelledby="commentaire-label"><g:fieldValue bean="${reponseInstance}" field="commentaire"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.intitule}">
				<li class="fieldcontain">
					<span id="intitule-label" class="property-label"><g:message code="reponse.intitule.label" default="Intitule" /></span>
					
						<span class="property-value" aria-labelledby="intitule-label"><g:fieldValue bean="${reponseInstance}" field="intitule"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.sessionRep}">
				<li class="fieldcontain">
					<span id="session-label" class="property-label"><g:message code="reponse.session.label" default="Session" /></span>
					
						<span class="property-value" aria-labelledby="session-label"><g:link controller="sessionReponse" action="show" id="${reponseInstance?.sessionRep?.id}">${reponseInstance?.sessionRep?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.valide}">
				<li class="fieldcontain">
					<span id="valide-label" class="property-label"><g:message code="reponse.valide.label" default="Valide" /></span>
					
						<span class="property-value" aria-labelledby="valide-label"><g:formatBoolean boolean="${reponseInstance?.valide}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.vote}">
				<li class="fieldcontain">
					<span id="vote-label" class="property-label"><g:message code="reponse.vote.label" default="Vote" /></span>
					
						<span class="property-value" aria-labelledby="vote-label"><g:fieldValue bean="${reponseInstance}" field="vote"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${reponseInstance?.id}" />
					<g:link class="edit" action="edit" id="${reponseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
