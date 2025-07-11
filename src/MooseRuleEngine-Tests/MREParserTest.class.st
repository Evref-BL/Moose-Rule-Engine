"
An ACRParserTest is a test class for testing the behavior of ACRParser
"
Class {
	#name : #MREParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'MooseRuleEngine-Tests'
}

{ #category : #running }
MREParserTest >> setUp [
	super setUp.

	parser := MREParser new.
]

{ #category : #tests }
MREParserTest >> testParse [

	| file model |
	file := MREFile new path: 'test.ts'; content: 'String test = "test"'.
	
	model := parser parse: file.
	
	self assert: model class equals: FASTTypescriptModel.
]

{ #category : #tests }
MREParserTest >> testParseJava [

	| file model |
	file := MREFile new
		        path: 'test.java';
		        content: 'public class Java {}'.

	model := parser parse: file.

	self assert: model class equals: FASTJavaModel.
]

{ #category : #tests }
MREParserTest >> testParseOtherFile [

	| file model |
	file := MREFile new
		        path: 'test.text';
		        content: 'text'.

	model := parser parse: file.

	self assert: model isNil
]

{ #category : #tests }
MREParserTest >> testParseTS [

	| model file tsCode |
	tsCode := 'String test = "test";'.
	file := MREFile new
		        path: 'test.ts';
		        content: tsCode.

	model := parser parseTS: file.
]
