
<%@ page import="interacquizz.SessionReponse"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>InteracQuizz - Valider les reponses</title>
	</head>
	<body>
		<div class="span12"></div>
		<div class="well span6 offset3">
			<fieldset>
				<legend>
					${ sessionReponseInstance.getQuestion() }
				</legend>
				<div class="alert alert-info">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>Voici les reponses de vos etudiants.</h4>
					Pensez à deconnecter le video projecteur avant de les valider.
				</div>
				<table class="table table-striped">
	
					<g:each in="${sessionReponseInstance.reponses}" var="reponse">
						<tr>
							<td class="">
								${ reponse }
							</td>
							<td>
								<div class="btn-group" reponse-id="${ reponse.getId() }">
									<button type="button"
										class="btn btn-success ${ reponse.getValide()?"active":"" }"
										data-value="true">Vrai</button>
									<button type="button"
										class="btn btn-danger ${ reponse.getValide()?"":"active" }"
										data-value="false">Faux</button>
								</div>
							</td>
						</tr>
					</g:each>
				</table>
			</fieldset>
		</div>
		<script>
				$(document).ready(function(){
					$("button").click(function(){
						var idReponse = $(this).parent(".btn-group").attr("reponse-id");
						 $(this).parent(".btn-group").children("button").addClass("disabled");
						if( $(this).attr("data-value") == "true" ){
							$.get("${ createLink(controller: "reponse", action: "setValide" ) }/"+idReponse, function(data) {
								if(data.erreur) {
									alert(data.erreur);
								}
								else {
									$("div[reponse-id="+data.id+"] button[data-value=false]").removeClass("active");
									$("div[reponse-id="+data.id+"] button[data-value=true]").addClass("active");
								}
								$("div[reponse-id="+data.id+"] button").removeClass("disabled");
							});
						}
						else {
							$.get("${ createLink(controller: "reponse", action: "setMauvaise" ) }/"+idReponse, function(data) {
								if(data.erreur) {
									alert(data.erreur);
								}
								else {
									$("div[reponse-id="+data.id+"] button[data-value=true]").removeClass("active");
									$("div[reponse-id="+data.id+"] button[data-value=false]").addClass("active");
								}
								$("div[reponse-id="+data.id+"] button").removeClass("disabled");
							});
						}
					});
				});
			</script>
	
	</body>
</html>
