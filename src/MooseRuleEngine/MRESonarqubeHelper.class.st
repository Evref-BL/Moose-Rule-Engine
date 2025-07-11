Class {
	#name : #MRESonarqubeHelper,
	#superclass : #MREHelper,
	#instVars : [
		'projectKey',
		'sonarqubeApi',
		'type',
		'mergeRequestId',
		'sourcePath'
	],
	#category : #MooseRuleEngine
}

{ #category : #'as yet unclassified' }
MRESonarqubeHelper >> allViolationsOf: rule inFile: file usingRuleId: ruleId [

	| params issues |
	params := {
		          (#componentKeys -> (projectKey , ':' , file path)).
		          (#rules -> ruleId) } asDictionary.

	issues := sonarqubeApi issues searchWithParams: params.
	issues := issues select: [ :issue | (issue at: #status) = 'OPEN' ].

	^ issues collect: [ :issue |
		  self parseIssueIntoViolation: issue ofRule: rule inFile: file ]
]

{ #category : #accessing }
MRESonarqubeHelper >> mergeRequestId: anObject [

	mergeRequestId := anObject
]

{ #category : #accessing }
MRESonarqubeHelper >> name [

	^ 'sonarqube'
]

{ #category : #parsing }
MRESonarqubeHelper >> parseIssueIntoViolation: issue ofRule: rule inFile: file [

	| textRange violation flows |
	textRange := issue at: #textRange.

	violation := MREViolation new rule: rule.
	violation addEntity:
		(self parseTextRangeIntoEntity: textRange ofFile: file).

	flows := issue at: #flows.
	flows ifNotEmpty: [
		flows do: [ :flow |
			| location |
			location := (flow at: #locations) first.
			textRange := location at: #textRange.
			violation addEntity:
				(self parseTextRangeIntoEntity: textRange ofFile: file) ] ].
		
	violation rule description: (issue at: #message).

	^ violation
]

{ #category : #parsing }
MRESonarqubeHelper >> parseTextRangeIntoEntity: textRange ofFile: file [

	| indexesStartLine indexesEndLine entityStartPos entityEndPos |
	indexesStartLine := file content indexesOfLine:
		                    (textRange at: #startLine).
	indexesEndLine := file content indexesOfLine:
		                  (textRange at: #endLine).

	entityStartPos := (indexesStartLine at: #start)
	                  + (textRange at: #startOffset).
	entityEndPos := (indexesEndLine at: #start)
	                + (textRange at: #endOffset) - 1.


	^ MREEntity new
		  file: file;
		  startPos: entityStartPos;
		  endPos: entityEndPos
]

{ #category : #accessing }
MRESonarqubeHelper >> projectKey: anObject [

	projectKey := anObject
]

{ #category : #accessing }
MRESonarqubeHelper >> sonarqubeApi: anObject [

	sonarqubeApi := anObject
]

{ #category : #accessing }
MRESonarqubeHelper >> sourcePath: anObject [

	sourcePath := anObject
]

{ #category : #accessing }
MRESonarqubeHelper >> type: anObject [

	type := anObject
]

{ #category : #'as yet unclassified' }
MRESonarqubeHelper >> violationsInMergeRequestOf: rule inFile: file usingRuleId: ruleId [

	| params issues |
	params := {
		          (#componentKeys -> (projectKey , ':' , file path)).
		          (#pullRequest -> mergeRequestId).
		          (#rules -> ruleId) } asDictionary.

	issues := sonarqubeApi issues searchWithParams: params.

	issues := issues select: [ :issue | (issue at: #status) = 'OPEN' ].

	^ issues collect: [ :issue |
		  self parseIssueIntoViolation: issue ofRule: rule inFile: file ]
]

{ #category : #'as yet unclassified' }
MRESonarqubeHelper >> violationsOf: rule inFile: file usingRuleId: ruleId [

	type = 'mergeRequest' ifTrue: [
		^ self
			  violationsInMergeRequestOf: rule
			  inFile: file
			  usingRuleId: ruleId ].
		
	type = 'all' ifTrue: [ 
		
		^self allViolationsOf: rule inFile: file usingRuleId: ruleId.	
	]
]
