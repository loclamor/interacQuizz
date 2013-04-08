
<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'sessionReponse.label', default: 'SessionReponse')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-sessionReponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sessionReponse" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list sessionReponse">
			
				<g:if test="${sessionReponseInstance?.cleeAcces}">
				<li class="fieldcontain">
					<span id="cleeAcces-label" class="property-label"><g:message code="sessionReponse.cleeAcces.label" default="Clee Acces" /></span>
					
						<span class="property-value" aria-labelledby="cleeAcces-label"><g:fieldValue bean="${sessionReponseInstance}" field="cleeAcces"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionReponseInstance?.cloture}">
				<li class="fieldcontain">
					<span id="cloture-label" class="property-label"><g:message code="sessionReponse.cloture.label" default="Cloture" /></span>
					
						<span class="property-value" aria-labelledby="cloture-label"><g:formatBoolean boolean="${sessionReponseInstance?.cloture}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionReponseInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="sessionReponse.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:link controller="question" action="show" id="${sessionReponseInstance?.question?.id}">${sessionReponseInstance?.question?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionReponseInstance?.reponses}">
				<li class="fieldcontain">
					<span id="reponses-label" class="property-label"><g:message code="sessionReponse.reponses.label" default="Reponses" /></span>
					
						<g:each in="${sessionReponseInstance.reponses}" var="r">
						<span class="property-value" aria-labelledby="reponses-label"><g:link controller="reponse" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${sessionReponseInstance?.visible}">
				<li class="fieldcontain">
					<span id="visible-label" class="property-label"><g:message code="sessionReponse.visible.label" default="Visible" /></span>
					
						<span class="property-value" aria-labelledby="visible-label"><g:formatBoolean boolean="${sessionReponseInstance?.visible}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${sessionReponseInstance?.id}" />
					<g:link class="edit" action="edit" id="${sessionReponseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
