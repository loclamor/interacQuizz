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
				if( session.aVote?.sessionRep?.getId() == sessionReponseInstance.getId() ) {
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
		
		if( session.aVote?.sessionRep?.getId() == reponseInstance.sessionRep.getId() ) {
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
		
		flash.messageInfo = "Vote enregistr&eacute;"
		session.aVote = reponseInstance
		redirect( action: "phaseResultat", id: reponseInstance.sessionRep.getId() )
	}
	
	def phaseResultat(Long id) {
		
		def sessionReponseInstance = SessionReponse.get(id)
		if( !sessionReponseInstance) {
			flash.messageErreur = "Session inconnue"
			redirect(uri: "/")
		}
		
		if ( sessionReponseInstance.getPhase() != "resultat") {
			flash.voteEnCours = true
			[sessionReponseInstance: sessionReponseInstance]
		}
		else {
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
			redirect( action: "validationReponses", id: id )
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
			redirect( action: "validationReponses", id: id )
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
			redirect( action: "validationReponses", id: id )
			return
		}
		[sessionReponseInstance: sessionReponseInstance]
	}
	
	def cloturerVote(Long id) {
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
	
		sessionReponseInstance.setPhase("resultat")
		
		if (!sessionReponseInstance.save(flush: true)) {
			sessionReponseInstance.errors.allErrors.each( {e -> println (e) } )
			flash.messageErreur = "erreur d'enregistrement"
			flash.id = id
			redirect( action: "lancerVote", id: id )
			return
		}
		
		redirect( action: "phaseResultat", id: id )
	}

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def question = Question.get(id)
		if(!question) {
			flash.message = "question inconnue"
			redirect(controller: "question", action: "list")
			return
		}
		def sessionReponseInstanceList = SessionReponse.findAllByQuestion(question)
        [sessionReponseInstanceList : sessionReponseInstanceList,
			sessionReponseInstanceTotal: sessionReponseInstanceList.size(),
			questionInstance: question]
    }

    def create(Long id) {
		def question = Question.get(id)
		if(!question) {
			flash.message = "question inconnue"
			redirect(controller: "question", action: "list")
			return
		}
        [question: question, sessionReponseInstance: new SessionReponse(params)]
    }

    def save() {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def sessionReponseInstance = new SessionReponse(params)
        if (!sessionReponseInstance.save(flush: true)) {
			flash.message = "une erreur est survenue. La clee d'acces doit etre unique"
			redirect(action: "create", id: sessionReponseInstance.question.id)
            //render(view: "create", model: [sessionReponseInstance: sessionReponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), sessionReponseInstance.id])
        redirect(action: "list", id: sessionReponseInstance.question.id)
    }

    def show(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def sessR = SessionReponse.get(id)
        if (!sessR) {
            flash.message = "session inconnue"
            redirect(action: "list")
            return
        }

		switch (sessR.getPhase()) {
			case "ajoutReponses":
				redirect(action: "validationReponses", id: sessR.id)
				break;
			case "validation":
				redirect(action: "validationReponses", id: sessR.id)
				break;
			case "vote":
				redirect(action: "lancerVote", id: sessR.id)
				break;
			case "resultat":
				redirect(action: "phaseResultat", id: sessR.id)
				break;
	
			default:
				flash.message = "phase de question inconnue"
				redirect(action: "list")
				break;
		}
		
    }

    def edit(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        [sessionReponseInstance: sessionReponseInstance]
    }

    def update(Long id, Long version) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
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
        redirect(action: "list", id: sessionReponseInstance.question.id)
    }

    def delete(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        try {
			def reponses = Reponse.findAllBySessionRep(sessionReponseInstance)
			for (Reponse rep : reponses) {
				rep.delete(flush: true)
			}
            sessionReponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list", id: id)
        }
    }
}
