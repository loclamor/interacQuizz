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
		
		out << "<div class=\"row-fluid chart\"><div class=\"span12\"></div>"
		itVotes = votes.iterator()
		while( itVotes.hasNext() ) {
			def vote = itVotes.next()
			def percent = vote.value * 100 / nbVotes
			/*if( percent == 0 ) {
				percent = 1
			}*/
			
			def reponse = Reponse.get( vote.key )
			
			out << plot( [percent: percent, nbre: vote.value, valide: reponse.getValide()], reponse.toString() )
			plot
		}
		out << "</div>"
		
	}
	def plot = { attrs, body ->
		def statutClass = "error"
		if( attrs.valide ){
			statutClass = "success"
		}
		out << "<div class=\"span12 plot plot-" << statutClass << "\" ><div class=\"bar\" style=\"width: "
		out << attrs.percent << "%\">" << attrs.nbre << " - " << attrs.percent.toInteger() << "%</div><span class=\"label-plot\" >"
		out << body() << "</span></div>"
	}
}
