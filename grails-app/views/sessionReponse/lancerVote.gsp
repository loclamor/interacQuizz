
<%@ page import="interacquizz.SessionReponse"%>
<%@ page import="interacquizz.Reponse"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Vote en cours</title>
	</head>
	<body>
		<div class="span12"></div>
		<div class="well span8 offset2">
			<fieldset>
				<legend>
					${ sessionReponseInstance.getQuestion() }
					<span class="muted pull-right">
						Phase de vote 
						<g:link controller="sessionReponse" action="cloturerVote" id="${ sessionReponseInstance.getId() }" class="btn" role="button" ><i class="icon-time"></i> Clôturer</g:link>
					</span>
				</legend>
				<div class="alert alert-info">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>Vos étudiants sont entrain de voter.</h4>
					Quand ils seront prêts, clôturez la phase de vote pour passer à la visualisation des résultats.
				</div>
				
			</fieldset>
		</div>
		
	</body>
</html>
