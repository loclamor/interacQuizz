package interacquizz

import org.springframework.dao.DataIntegrityViolationException

class SessionReponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def connect() {
		
		def sessR = SessionReponse.findByCleeAcces(params.get("codeSession"))
		if(!sessR){
			//flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), params.get("codeSession")])
			flash.messageErreur = "ce code est inconnu"
			redirect(uri: "/")
			return
		}
		
		println("connexion a la session " + sessR.id + " pour la question \"" + sessR.getQuestion() + "\"")
		println("session en phase " + sessR.getPhase())
		
		switch (sessR.getPhase()) {
			case "ajoutReponses":
				redirect(action: "phaseAjoutReponses", id: sessR.id)
				break;
			case "validation":
				redirect(action: "phaseValidation", id: sessR.id)
				break;
			case "vote":
				redirect(action: "phaseVote", id: sessR.id)
				break;
			case "resultat":
				redirect(action: "phaseResultat", id: sessR.id)
				break;
	
			default:
				flash.messageErreur = "phase de question inconnue"
				redirect(uri: "/")
				break;
		}
		
		
	}
	
	def phaseAjoutReponses(Long id) {
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
			return
		}
		[sessionReponseInstance: sessionReponseInstance]
	}
	
	def phaseValidation(Long id) {
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
		}
		
		[sessionReponseInstance: sessionReponseInstance]
	}
	
	def phaseVote(Long id) {
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
		}
		
		switch (sessionReponseInstance.getPhase()) {
			case "ajoutReponses":
				flash.messageInfo = "phase d'ajout de r&eacute;ponses"
				redirect(action: "phaseAjoutReponses", id: id)
				return
				break;
			case "validation":
				flash.messageInfo = "phase de validation en cours"
				redirect(action: "phaseValidation", id: id)
				return
				break;
			case "resultat":
				redirect(action: "phaseResultat", id: id)
				return
				break;
			case "vote":
				if( session.aVote ) {
					flash.messageInfo = "Vous avez deja vot&eacute;"
					redirect(action: "phaseResultat", id: id)
					return
				}
				break
			default:
				break;
		}
		[sessionReponseInstance: sessionReponseInstance, reponsesInstance: Reponse.findAllBySessionRep(sessionReponseInstance)]
	}
	
	def voter(Long id) {
		def reponseInstance = Reponse.get(id)
		if( !reponseInstance) {
			flash.messageErreur = "Reponse inconnue"
			redirect(uri: "/")
		}
		
		if( session.aVote ) {
			flash.messageInfo = "Vous avez deja vot&eacute;"
			redirect( action: "phaseResultat", id: reponseInstance.sessionRep.getId() )
			return
		}
		
		def vote = new Vote(reponse: reponseInstance)
		if (!vote.save(flush: true)) {
			vote.errors.allErrors.each( {e -> println (e) } )
			flash.messageErreur = "erreur d'enregistrement"
			redirect( action: "phaseVote", id: reponseInstance.sessionRep.getId() )
			return
		}
		
		session.aVote = reponseInstance
		redirect( action: "phaseResultat", id: reponseInstance.sessionRep.getId() )
	}
	
	def phaseResultat(Long id) {
		
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
		}
		
		def reponses = Reponse.findAllBySessionRep(sessionReponseInstance)
		def votesMap = [:]
		
		for (Reponse rep : reponses) {
			def votes = Vote.countByReponse( rep )
			votesMap[rep.getId()] = votes
		}
		
		println(votesMap)
		
		[sessionReponseInstance: sessionReponseInstance,
			reponsesInstance: reponses,
			votes: votesMap]
	}
	
	def validationReponses(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
		}
		[sessionReponseInstance: sessionReponseInstance, reponsesInstance: Reponse.findAllBySessionRep(sessionReponseInstance)]
	}
	
	def cloturerReponses(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
			return
		}
		
		sessionReponseInstance.setPhase("validation")
		
		if (!sessionReponseInstance.save(flush: true)) {
			sessionReponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.messageErreur = "erreur d'enregistrement"
			flash.id = id
			redirect(uri: "/")
			return
		}
		
		redirect(action: "validationReponses", params: params)
	}
	
	def retourAjout(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
			return
		}
		
		sessionReponseInstance.setPhase("ajoutReponses")
		
		if (!sessionReponseInstance.save(flush: true)) {
			sessionReponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.messageErreur = "erreur d'enregistrement"
			flash.id = id
			redirect(uri: "/")
			return
		}
		
		redirect(action: "validationReponses", params: params)
	}
	def lancerVote(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
			return
		}
		
		sessionReponseInstance.setPhase("vote")
		
		if (!sessionReponseInstance.save(flush: true)) {
			sessionReponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.messageErreur = "erreur d'enregistrement"
			flash.id = id
			redirect(uri: "/")
			return
		}
		[sessionReponseInstance: sessionReponseInstance]
	}

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [sessionReponseInstanceList: SessionReponse.list(params),
			sessionReponseInstanceTotal: SessionReponse.count()]
    }

    def create() {
        [sessionReponseInstance: new SessionReponse(params)]
    }

    def save() {
        def sessionReponseInstance = new SessionReponse(params)
        if (!sessionReponseInstance.save(flush: true)) {
            render(view: "create", model: [sessionReponseInstance: sessionReponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), sessionReponseInstance.id])
        redirect(action: "show", id: sessionReponseInstance.id)
    }

    def show(Long id) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        [sessionReponseInstance: sessionReponseInstance]
    }

    def edit(Long id) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        [sessionReponseInstance: sessionReponseInstance]
    }

    def update(Long id, Long version) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (sessionReponseInstance.version > version) {
                sessionReponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sessionReponse.label', default: 'SessionReponse')] as Object[],
                          "Another user has updated this SessionReponse while you were editing")
                render(view: "edit", model: [sessionReponseInstance: sessionReponseInstance])
                return
            }
        }

        sessionReponseInstance.properties = params

        if (!sessionReponseInstance.save(flush: true)) {
            render(view: "edit", model: [sessionReponseInstance: sessionReponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), sessionReponseInstance.id])
        redirect(action: "show", id: sessionReponseInstance.id)
    }

    def delete(Long id) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        try {
            sessionReponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "show", id: id)
        }
    }
}
