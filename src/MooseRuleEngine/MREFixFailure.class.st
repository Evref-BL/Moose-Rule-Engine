"
I record a violation whose rule raised in fix:, with the error and its stack from the error down to the rule's fix:, so the engine can go on with the other violations.
fuelOutTo:redacting: writes that stack to a Fuel file, as the debugger's ""Fuel out stack"" does. Materialized in an image with the same code (FLMaterializer materializeFromFileNamed:), it opens a debugger on the error, where fix: can be restarted and stepped.
"
Class {
	#name : 'MREFixFailure',
	#superclass : 'Object',
	#instVars : [
		'violation',
		'error',
		'stack'
	],
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
}

{ #category : 'instance creation' }
MREFixFailure class >> violation: aViolation error: anError [
	"Copy the stack now, before the handler returns and unwinds it, and only down to the rule's fix:: below are the engine and its caller, which a Fuel file must not hold (their methods may not exist where it is materialized)"

	| engineContext |
	engineContext := anError signalerContext findContextSuchThat: [ :context |
		                 context homeMethod == (MooseRuleEngine >> #fix:) ].
	^ self new
		  setViolation: aViolation
		  error: anError
		  stack: (anError signalerContext copyTo: engineContext)
]

{ #category : 'printing' }
MREFixFailure >> description [

	^ '{1} fix: failed on {2}: {3}' format: {
			  violation rule class name.
			  violation entities
				  ifEmpty: [ 'a violation without entity' ]
				  ifNotEmpty: [ :entities |
					  entities first file path , ' at ' , entities first startPos printString ].
			  error description }
]

{ #category : 'accessing' }
MREFixFailure >> error [

	^ error
]

{ #category : 'fuel' }
MREFixFailure >> fuelOutTo: aFileReference redacting: secrets [
	"Write the stack to a Fuel file, each of the secrets strings (tokens, API keys) replaced"

	FLDebuggerStackSerializer new
		when: [ :object | object isString and: [ secrets includes: object ] ]
		substituteBy: [ :secret | '<redacted>' ];
		serializeStackFromContext: stack
		toFileNamed: aFileReference fullName
]

{ #category : 'initialization' }
MREFixFailure >> setViolation: aViolation error: anError stack: aContext [

	violation := aViolation.
	error := anError.
	stack := aContext
]

{ #category : 'accessing' }
MREFixFailure >> stack [
	"A copy of the stack of the error, from the context that signaled it down to the rule's fix:"

	^ stack
]

{ #category : 'accessing' }
MREFixFailure >> violation [

	^ violation
]
