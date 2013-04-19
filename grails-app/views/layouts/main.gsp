<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="InteracQuizz" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon"
	href="${resource(dir: 'images', file: 'favicon.ico')}"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

<link rel="stylesheet"
	href="${resource(dir: 'bootstrap/css', file: 'bootstrap.css')}"
	type="text/css">
<!-- <link rel="stylesheet"
	href="${resource(dir: 'bootstrap/css', file: 'bootstrap-responsive.css')}"
	type="text/css"> -->
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'supplement.css')}" type="text/css">
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="${resource(dir: 'bootstrap/js', file: 'bootstrap.js')}"></script>
<g:layoutHead />
<r:layoutResources />
</head>
<body>
	<div class="navbar">
		<div class="navbar-inner">
			<a class="brand" href="${createLink(uri: '/')}">InteracQuizz</a>
			<ul class="nav">
				<li><a href="${createLink(uri: '/')}">Accéder à une
						question</a></li>
				<li><g:link controller="professeur" action="connect">Compte Professeur</g:link></li>
			</ul>
			<g:if test="${ session.prof }">
				<ul class="nav pull-right">
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">
						Connecté en tant que ${ session.prof }
						<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><g:link controller="question" action="list" ><i class="icon-list"></i> Mes questions</g:link></li>
							<li class="divider"></li>
							<li><g:link controller="professeur" action="edit" id="${ session.prof.getId() }" ><i class="icon-pencil"></i> Editer mon profil</g:link></li>
							<li class="divider"></li>
							<li><g:link controller="professeur" action="create" ><i class="icon-plus" ></i> Créer un professeur</g:link></li>
							<li class="divider"></li>
							<li><g:link controller="professeur" action="deconnexion" class=""><i class="icon-off"></i> Se déconnecter</g:link></li>
						</ul>
					</li>
				</ul>
			</g:if>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<g:layoutBody />
		</div>
	</div>
	<div class="footer" role="contentinfo"></div>
	<div id="spinner" class="spinner" style="display: none;">
		<g:message code="spinner.alt" default="Loading&hellip;" />
	</div>
	<g:javascript library="application" />
	<r:layoutResources />
</body>
</html>
