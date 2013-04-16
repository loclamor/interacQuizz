
<%@ page import="interacquizz.SessionReponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Valider les reponses</title>
	</head>
	<body>
		<div class="span12"></div>
		<div class="well span6 offset3">
			<fieldset >
				<legend>${ sessionReponseInstance.getQuestion() }</legend>
				    <div class="alert alert-info">
				    	<button type="button" class="close" data-dismiss="alert">&times;</button>
				    	<h4>Voici les reponses de vos etudiants.</h4>
				    	Pensez à deconnecter le video projecteur avant de les valider.
				    </div>
				<table class="table table-striped" >
					
					<g:each in="${sessionReponseInstance.reponses}" var="reponse">
						<tr>
							<td class="">${ reponse }</td>
							<td>
								<div class="btn-group" data-toggle="buttons-radio" reponse-id="${ reponse.getId() }">
							   		<button type="button" class="btn btn-success ${ reponse.getValide()?"active":"" }">Vrai</button>
							  		<button type="button" class="btn btn-danger ${ reponse.getValide()?"":"active" }">Faux</button>
								</div>
							</td>
						</tr>
					</g:each>
				</div>
			</fieldset>
		</div>
		
		
	</body>
</html>
