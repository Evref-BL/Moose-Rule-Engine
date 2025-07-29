Class {
	#name : 'MREFix',
	#superclass : 'Object',
	#instVars : [
		'startPos',
		'endPos',
		'content',
		'file'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'as yet unclassified' }
MREFix >> applyOnFile [

	| before after |
	before := file content copyFrom: 1 to: startPos - 1.
	after := startPos = endPos
		         ifTrue: [
		         file content copyFrom: startPos to: file content size ]
		         ifFalse: [
		         file content
			         copyFrom: endPos + 1
			         to: file content size ].
	^ before , content , after
]

{ #category : 'accessing' }
MREFix >> content [

	^ content
]

{ #category : 'accessing' }
MREFix >> content: anObject [

	content := anObject
]

{ #category : 'accessing' }
MREFix >> endLine [

	^ file content lineNumberCorrespondingToIndex: endPos
]

{ #category : 'accessing' }
MREFix >> endPos [

	^ endPos
]

{ #category : 'accessing' }
MREFix >> endPos: anObject [

	endPos := anObject
]

{ #category : 'accessing' }
MREFix >> file [

	^ file
]

{ #category : 'accessing' }
MREFix >> file: anObject [

	file := anObject
]

{ #category : 'instance creation' }
MREFix >> newLines [

	| newFile startLine endLine lines startLineIndexes endLineIndexes |
	startLineIndexes := file content indexesOfLine: self startLine.
	endLineIndexes := file content indexesOfLine: self endLine.

	 ((startLineIndexes at: #start) = startPos and:
		  ((endLineIndexes at: #end) = endPos and: content = '')) ifTrue: [
		^ '' ].

	newFile := self applyOnFile.

	startLine := newFile lineNumberCorrespondingToIndex: startPos.
	endLine := newFile lineNumberCorrespondingToIndex:
		           startPos + content size.


	lines := newFile lines copyFrom: startLine to: endLine.

	^ lines inject: '' into: [ :acc :line |
		  '' join: {
				  acc.
				  line.
				  Character lf asString } ]
]

{ #category : 'accessing' }
MREFix >> startLine [

	^ file content lineNumberCorrespondingToIndex: startPos
]

{ #category : 'accessing' }
MREFix >> startPos [

	^ startPos
]

{ #category : 'accessing' }
MREFix >> startPos: anObject [

	startPos := anObject
]
