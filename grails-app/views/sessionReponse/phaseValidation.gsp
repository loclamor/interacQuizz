
<%@ page import="interacquizz.SessionReponse"%>
<%@ page import="interacquizz.Reponse"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Validation en cours</title>
	</head>
	<body>
		<div class="span12"></div>
		<div class="well span8 offset2">
			<fieldset>
				<legend>
					${ sessionReponseInstance.getQuestion() }
					<span class="muted pull-right">
						Phase de validation des réponses 
						<g:link controller="sessionReponse" action="phaseVote" id="${ sessionReponseInstance.getId() }" class="btn" role="button" ><i class="icon-fast-forward"></i> Vote</g:link>
					</span>
				</legend>
				<div class="alert alert-info">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>Votre professeur est en train de valider vos réponses.</h4>
					Attendez son signal pour passer à la phase de vote.
				</div>
				
			</fieldset>
		</div>
		
	</body>
</html>
