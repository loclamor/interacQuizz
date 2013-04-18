package interacquizz

import org.springframework.dao.DataIntegrityViolationException

class ReponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
		
	def setValide(Long id) {
		def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "reponse inexistante"
			flash.id = id
            render(contentType: "text/json") {
				flash
			}
            return
        }

		reponseInstance.setValide(true)

		if (!reponseInstance.save(flush: true)) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "erreur d'enregistrement"
			flash.id = id
            render(contentType: "text/json") {
				flash
			}
			return
		}
		
		render(contentType: "text/json") {
			reponseInstance
		}
	}
	
	def setMauvaise(Long id) {
		def reponseInstance = Reponse.get(id)
		if (!reponseInstance) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "reponse inexistante"
			flash.id = id
            render(contentType: "text/json") {
				flash
			}
			return
		}
		
		reponseInstance.setValide(false)
		
		if (!reponseInstance.save(flush: true)) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "erreur d'enregistrement"
			flash.id = id
			render(contentType: "text/json") {
				flash
			}
			return
		}
		
		render(contentType: "text/json") {
			reponseInstance
		}
	}
	
	def getJson(Long id) {
		def reponseInstance = Reponse.get(id)
		if (!reponseInstance) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "reponse inexistante"
			flash.id = id
			render(contentType: "text/json") {
				flash
			}
			return
		}
		
		render(contentType: "text/json") {
			reponseInstance
		}
	}
	
	def setCommentaire(Long id) {
		def reponseInstance = Reponse.get(id)
		if (!reponseInstance) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "reponse inexistante"
			flash.id = id
			render(contentType: "text/json") {
				flash
			}
			return
		}
		
		reponseInstance.setCommentaire(params.reponseCommentaire)
		reponseInstance.setIntitule(params.reponseIntitule)
		
		if (!reponseInstance.save(flush: true)) {
			reponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.erreur = "erreur d'enregistrement"
			flash.id = id
			render(contentType: "text/json") {
				flash
			}
			return
		}
		
		render(contentType: "text/json") {
			reponseInstance
		}
	}
	
	def ajout() {
		
		def sessR = SessionReponse.get(params.get("idSessionReponse"))
		if(!sessR) {
			println("!!!! session " + params.get("idSessionReponse") + " non trouvee")
			flash.messageErreur = "Impossible de trouver la session"
			redirect(controller: "sessionReponse", action: "phaseAjoutReponses", id: params.get("idSessionReponse"))
			return
		}
		
		if(sessR.getPhase() != "ajoutReponses") {
			println("Ajout hors phase")
			flash.messageErreur = "Phase d'ajout terminee. Passez a la phase suivante."
			redirect(controller: "sessionReponse", action: "phaseAjoutReponses", id: params.get("idSessionReponse"))
			return
		}
		
		def rep = new Reponse(intitule: params.get("nouvelleReponse"), commentaire: "", sessionRep: sessR, valide: false, vote: 0)
		if(!rep.save(flush:true)){
			println("!!!! erreur enregistrement reponse");
			flash.messageErreur = "Une erreur est survenue lors de l'enregistrement de la reponse"
			rep.errors.allErrors.each( {e -> println (e) } )
		}
		else {
			println("Reponse \"" + rep + "\" ajoutee a la question \"" + sessR.getQuestion() + "\"")
			flash.messageInfo = "Reponse ajoutee"
		}
		redirect(controller: "sessionReponse", action: "phaseAjoutReponses", id: params.get("idSessionReponse"))
	}
	
	def ajoutProfesseur(Long id){
		def sessR = SessionReponse.get(id)
		if(!sessR) {
			println("!!!! session " + id + " non trouvee")
			flash.messageErreur = "Impossible de trouver la session"
			redirect(controller: "sessionReponse", action: "validationReponses", id: id)
			return
		}
		
		if(sessR.getPhase() != "ajoutReponses") {
			println("Ajout hors phase")
			flash.messageErreur = "Phase d'ajout terminee. Passez a la phase suivante."
			redirect(controller: "sessionReponse", action: "validationReponses", id: id)
			return
		}
		
		def rep = new Reponse(intitule: params.get("nouvelleReponse"), commentaire: "", sessionRep: sessR, valide: false, vote: 0)
		if(!rep.save(flush:true)){
			println("!!!! erreur enregistrement reponse");
			flash.messageErreur = "Une erreur est survenue lors de l'enregistrement de la reponse"
			rep.errors.allErrors.each( {e -> println (e) } )
		}
		else {
			println("Reponse \"" + rep + "\" ajoutee a la question \"" + sessR.getQuestion() + "\"")
			flash.messageInfo = "Reponse ajoutee"
		}
		redirect(controller: "sessionReponse", action: "validationReponses", id: id)
	}

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [reponseInstanceList: Reponse.list(params), reponseInstanceTotal: Reponse.count()]
    }

    def create() {
        [reponseInstance: new Reponse(params)]
    }

    def save() {
        def reponseInstance = new Reponse(params)
        if (!reponseInstance.save(flush: true)) {
            render(view: "create", model: [reponseInstance: reponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'reponse.label', default: 'Reponse'), reponseInstance.id])
        redirect(action: "show", id: reponseInstance.id)
    }

    def show(Long id) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        [reponseInstance: reponseInstance]
    }

    def edit(Long id) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        [reponseInstance: reponseInstance]
    }

    def update(Long id, Long version) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (reponseInstance.version > version) {
                reponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'reponse.label', default: 'Reponse')] as Object[],
                          "Another user has updated this Reponse while you were editing")
                render(view: "edit", model: [reponseInstance: reponseInstance])
                return
            }
        }

        reponseInstance.properties = params

        if (!reponseInstance.save(flush: true)) {
            render(view: "edit", model: [reponseInstance: reponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'reponse.label', default: 'Reponse'), reponseInstance.id])
        redirect(action: "show", id: reponseInstance.id)
    }

    def delete(Long id) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        try {
            reponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "show", id: id)
        }
    }
}
