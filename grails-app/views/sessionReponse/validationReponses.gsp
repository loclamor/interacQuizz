
<%@ page import="interacquizz.SessionReponse"%>
<%@ page import="interacquizz.Reponse"%>
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
						<tr reponse-id="${ reponse.getId() }">
							<td>
								<span class="reponseIntitule">${ reponse }</span><br>
								<span class="reponseCommentaire muted">${ reponse.getCommentaire() }</span>
							</td>
							<td>
								<div class="btn-group trueFalseSwitcher" >
									<button type="button"
										class="btn btn-success ${ reponse.getValide()?"active":"" }"
										data-value="true">Vrai</button>
									<button type="button"
										class="btn btn-danger ${ reponse.getValide()?"":"active" }"
										data-value="false">Faux</button>
								</div>
							</td>
							<td>
								<a class="btn edit-btn" href="#modalEdit" role="button" data-toggle="modal" ><i class="icon-pencil"></i></a>
							</td>
						</tr>
					</g:each>
				</table>
			</fieldset>
		</div>
		<div id="modalEdit" class="modal hide fade" tabindex="-1" role="dialog"
			aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h3 id="modalLabel">intitule question</h3>
			</div>
			<div class="modal-body">
				<div class="form-horizontal">
					<div class="control-group">
						<label class="control-label" for="reponseIntitule">Intitule</label>
						<div class="controls">
							<g:textField name="reponseIntitule"  class="span12" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="reponseCommentaire">Commentaire</label>
						<div class="controls">
							<g:textArea name="reponseCommentaire" class="span12" ></g:textArea>
						</div>
					</div>
					<g:hiddenField name="reponseId"/>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Annuler</button>
				<button class="btn btn-primary save">Enregistrer</button>
			</div>
		</div>
		<script>
			$(document).ready(function(){

				//pseudo boutons radio Vrai/Faux
				$(".trueFalseSwitcher button").click(function(){
					var idReponse = $(this).parents("tr").attr("reponse-id");
					 $(this).parent(".btn-group").children("button").addClass("disabled");
					if( $(this).attr("data-value") == "true" ){
						$.get("${ createLink(controller: "reponse", action: "setValide" ) }/"+idReponse, function(data) {
							if(data.erreur) {
								alert(data.erreur);
							}
							else {
								$("tr[reponse-id="+data.id+"] .trueFalseSwitcher button[data-value=false]").removeClass("active");
								$("tr[reponse-id="+data.id+"] .trueFalseSwitcher button[data-value=true]").addClass("active");
							}
							$("tr[reponse-id="+data.id+"] .trueFalseSwitcher button").removeClass("disabled");
						});
					}
					else {
						$.get("${ createLink(controller: "reponse", action: "setMauvaise" ) }/"+idReponse, function(data) {
							if(data.erreur) {
								alert(data.erreur);
							}
							else {
								$("tr[reponse-id="+data.id+"] .trueFalseSwitcher button[data-value=true]").removeClass("active");
								$("tr[reponse-id="+data.id+"] .trueFalseSwitcher button[data-value=false]").addClass("active");
							}
							$("tr[reponse-id="+data.id+"] .trueFalseSwitcher button").removeClass("disabled");
						});
					}
				});

				//Bouton edition reponse
				$('.edit-btn').click(function () {
					//init forms
					var idReponse = $(this).parents("tr").attr("reponse-id");
					$.get("${ createLink(controller: "reponse", action: "getJson" ) }/"+idReponse, function(data) {
						if(data.erreur) {
							alert(data.erreur);
							$('#modalEdit').modal('hide');
						}
						else {
							
							$('#modalEdit #modalLabel').html(data.intitule);
							$('#modalEdit #reponseIntitule').val(data.intitule);
							$('#modalEdit #reponseCommentaire').val(data.commentaire);
							$('#modalEdit #reponseId').val(data.id);
						}
						
					});
					
				});

				$('#modalEdit button.save').click(function(){
					//save data
					$('#modalEdit button.save').addClass("disabled");
					var idReponse = $('#modalEdit #reponseId').val();
					var intitule = $('#modalEdit #reponseIntitule').val();
					var commentaire = $('#modalEdit #reponseCommentaire').val();
					$.post("${ createLink(controller: "reponse", action: "setCommentaire" ) }/"+idReponse, { reponseIntitule: intitule, reponseCommentaire: commentaire }, function(data) {
						if(data.erreur) {
							alert(data.erreur);
							$('#modalEdit').modal('hide');
						}
						else {
							
							$("tr[reponse-id="+data.id+"] .reponseIntitule").html(data.intitule);
							$("tr[reponse-id="+data.id+"] .reponseCommentaire").html(data.commentaire);
							$('#modalEdit').modal('hide');
						}
						$('#modalEdit button.save').removeClass("disabled");
					});
					
				});

				$('#modalEdit').on('hidden', function () {
					//reset forms
					$('#modalEdit #modalLabel').html("intitule question");
					$('#modalEdit #reponseIntitule').val("");
					$('#modalEdit #reponseCommentaire').val("");
					$('#modalEdit #reponseId').val("");
					$('#modalEdit button.save').removeClass("disabled");
				});
			});
		</script>
	</body>
</html>
