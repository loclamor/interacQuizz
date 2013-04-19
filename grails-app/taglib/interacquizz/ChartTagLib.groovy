package interacquizz

class ChartTagLib {
	
	def chart = { attrs, body -> 

		def votes = attrs["votes"]
		def nbRep = votes.size()
		def nbVotes = 0
		
		def itVotes = votes.iterator()
		while( itVotes.hasNext() ) {
			def vote = itVotes.next()
			nbVotes += vote.value
			println( vote.key + " - " + vote.value )
		}
		println( nbVotes + " votes sur " + nbRep + " reponses")
		
		out << "<div class=\"accordion chart\" id=\"chart-accordion\" >" //<div class=\"span12\"></div>
		itVotes = votes.iterator()
		while( itVotes.hasNext() ) {
			def vote = itVotes.next()
			def percent = vote.value * 100 / nbVotes
			
			def reponse = Reponse.get( vote.key )
			
			out << plot( [percent: percent, nbre: vote.value, valide: reponse.getValide(), idReponse: vote.key, commentaire: reponse.getCommentaire() ], reponse.toString() )
			plot
		}
		out << "</div>"

	}
	def plot = { attrs, body ->
		def statutClass = "error"
		if( attrs.valide ){
			statutClass = "success"
		}
		out << "<div class=\"accordion-group\" >"
			out << "<div class=\"accordion-heading\" >"
				out << "<a class=\"plot plot-" << statutClass << " accordion-toggle\" href=\"#commentaire-" << attrs.idReponse << "\" data-parent=\"#chart-accordion\" data-toggle=\"collapse\">"
					out << "<div class=\"bar\" style=\"width: " << attrs.percent << "%\">"
						out << attrs.nbre << " - " << attrs.percent.toInteger() << "%"
					out << "</div>"
					out << "<span class=\"label-plot\" >" << body() << "</span>"
				out << "</a>"
			out << "</div>"
			out << "<div class=\"accordion-body collapse\" id=\"commentaire-" << attrs.idReponse << "\" >"
				out << "<div class=\"accordion-inner\" >"
					out << attrs.commentaire
				out << "</div>"
			out << "</div>"
		out << "</div>"
	}
}
