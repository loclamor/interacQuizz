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
		
		out << "<div style=\"width: 100%; height: 100px;\">"
		itVotes = votes.iterator()
		while( itVotes.hasNext() ) {
			def vote = itVotes.next()
			
			out << "<div style=\"float: left; margin-left: 10px; background-color: red; text-align: center; width: 20px; height: " + (vote.value * 100 / nbVotes + 1) + "% \">" + vote.value + "</div>"
			
		}
		out << "</div>"
		
	}
}
