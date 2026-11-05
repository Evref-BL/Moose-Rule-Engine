"
I record a violation whose rule raised in fix:, with the error and a copy of its stack. The copy stays readable, and debuggable, after the error is unwound, so the engine can go on with the other violations.
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
	"Copy the stack now: once the handler returns, the signaler context loses its senders"

	^ self new setViolation: aViolation error: anError stack: anError signalerContext copyStack
]

{ #category : 'debugging' }
MREFixFailure >> debug [
	"Open a debugger on the copied stack, as if the error had not been caught"

	(Process forContext: stack priority: Processor userSchedulingPriority)
		debugWithTitle: self description
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

{ #category : 'initialization' }
MREFixFailure >> setViolation: aViolation error: anError stack: aContext [

	violation := aViolation.
	error := anError.
	stack := aContext
]

{ #category : 'accessing' }
MREFixFailure >> stack [
	"A copy of the stack of the error, from the context that signaled it"

	^ stack
]

{ #category : 'accessing' }
MREFixFailure >> violation [

	^ violation
]
