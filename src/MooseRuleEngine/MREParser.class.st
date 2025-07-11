Class {
	#name : #MREParser,
	#superclass : #Object,
	#category : #MooseRuleEngine
}

{ #category : #parsing }
MREParser >> parse: file [

	| extension |
	extension := file path asFileReference extension.
	
	[
	extension = 'java' ifTrue: [ ^ self parseJava: file ].

	extension = 'ts' ifTrue: [ ^ self parseTS: file ] ]
		on: Error
		do: [ :e |
			| errorMessage |
			errorMessage := 'error fixing ' , file path , ' : ' , e asString.
			Transcript
				show: errorMessage;
				cr ].

	^ nil
]

{ #category : #parsing }
MREParser >> parseJava: file [
	^ JavaSmaCCProgramNodeImporterVisitor new
			  withComments;
			  parseCodeString: file content
]

{ #category : #parsing }
MREParser >> parseTS: file [

	^ FASTTypescriptParser new getASTFromString: file content
]
