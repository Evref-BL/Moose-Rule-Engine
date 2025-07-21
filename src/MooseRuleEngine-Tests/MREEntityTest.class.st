"
A MREEntityTest is a test class for testing the behavior of MREEntity
"
Class {
	#name : 'MREEntityTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'tests' }
MREEntityTest >> testEndLine [

	| file entity startLine |
	file := MREFile new
		        path: 'test.java';
		        content: 'aaaaa
	aaaaa
	aaaaa
	aaaaa'.

	entity := MREEntity new
		          file: file;
		          endPos: 7.

	startLine := entity endLine.

	self assert: startLine equals: 2
]

{ #category : 'tests' }
MREEntityTest >> testStartLine [

	| file entity startLine |
	file := MREFile new
		        path: 'test.java';
		        content: 'aaaaa
	aaaaa
	aaaaa
	aaaaa'.

	entity := MREEntity new
		          file: file;
		          startPos: 7.

	startLine := entity startLine.

	self assert: startLine equals: 2
]

{ #category : 'tests' }
MREEntityTest >> testValue [

	| file entity value |
	file := MREFile new path: 'test.java'; content: 'aaa bbb'.
	
	entity := MREEntity new file: file; startPos: 1; endPos: 3.
	
	value := entity value.
	
	self assert: value equals: 'aaa'.
]
