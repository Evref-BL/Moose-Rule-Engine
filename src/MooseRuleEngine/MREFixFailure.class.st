"
I record a violation whose rule raised in fix:, with the error and a copy of its stack, so the engine can go on with the other violations.
- debug opens a debugger on the copied stack: the frames and variables as they were at the error.
- replay runs the fix: again on the same violation without catching its error: a live debugger, to step, change and restart.
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
	"Open a debugger on the copied stack, to read the frames and variables as they were at the error. To step through it, use replay"

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

{ #category : 'debugging' }
MREFixFailure >> replay [
	"Run the fix: again on the same violation, without catching its error, so a debugger opens on a live stack where it can be stepped, changed and restarted"

	^ violation rule fix: violation
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
