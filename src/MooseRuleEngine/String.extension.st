Extension { #name : 'String' }

{ #category : '*MooseRuleEngine' }
String >> indexesOfLine: aLineNumber [

	| iterator |
	iterator := 1.
	(self lineNumber: aLineNumber) ifNil: [
		self error: 'the line number is out of the scope of this string' ].

	self lineIndicesDo: [ :start :endWithoutDelimiters :end |
		iterator = aLineNumber ifTrue: [
			^ {
				  (#start -> start).
				  (#endWithoutDelimiters -> endWithoutDelimiters).
				  (#end -> end) } asOrderedDictionary ].
		iterator := iterator + 1 ]
]
