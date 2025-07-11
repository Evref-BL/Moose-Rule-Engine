"
A MRESonarqubeHelperTest is a test class for testing the behavior of MRESonarqubeHelper
"
Class {
	#name : #MRESonarqubeHelperTest,
	#superclass : #TestCase,
	#instVars : [
		'textRange'
	],
	#category : #'MooseRuleEngine-Tests'
}

{ #category : #running }
MRESonarqubeHelperTest >> setUp [
	super setUp.

	textRange := {
		             (#startLine -> 1).
		             (#startOffset -> 0).
		             (#endLine -> 1).
		             (#endOffset -> 10) } asDictionary.
]

{ #category : #tests }
MRESonarqubeHelperTest >> testAllViolationsOfInFileUsingRuleId [


	| mergeRequestId rule file ruleId helper violations projectKey sonarqubeApi issue1 issue2 params expectedEntity |
	mergeRequestId := 1.
	rule := MRERule new.
	file := MREFile new
		        path: 'test.ts';
		        content: 'class Java {}'.
	ruleId := 'java:1111'.
	projectKey := 'projectKey'.

	sonarqubeApi := SonarAPIMock new.

	issue1 := {
		          (#textRange -> textRange).
		          (#status -> 'OPEN').
		          (#flows -> {  }).
		
		#message -> 'message'
		 } asDictionary.
						
						
			

	issue2 := {
		          (#textRange -> textRange).
		          (#status -> 'CLOSE').
		          (#flows -> {  }) .
		
			#message -> 'message'} asDictionary.

	params := {
		          (#componentKeys -> (projectKey , ':' , file path)).
		          (#rules -> ruleId) } asDictionary.

	(sonarqubeApi issues stub searchWithParams: params) willReturn: {
			issue1.
			issue2 }.

	helper := MRESonarqubeHelper new
		          mergeRequestId: 1;
		          type: 'all';
		          projectKey: projectKey;
		          sonarqubeApi: sonarqubeApi.

	violations := helper
		              allViolationsOf: rule inFile: file  usingRuleId: ruleId.
		              
	self assert: violations size equals: 1.
	self assert: violations first rule equals: rule.

	expectedEntity := helper
		                  parseTextRangeIntoEntity: textRange
		                  ofFile: file.

	violations first entities do: [ :entity |
		self assert: entity file equals: expectedEntity file.
		self assert: entity startPos equals: expectedEntity startPos.
		self assert: entity endPos equals: expectedEntity endPos.
		self assert: entity model equals: expectedEntity model ]
]

{ #category : #tests }
MRESonarqubeHelperTest >> testParseIssueIntoViolationOfRuleInFile [

	| issue sonarHelper violation rule location1 location2 fileContent file expectedEntity message |
	rule := MRERule new.
	message := 'message'.

	fileContent := 'class Java {}'.
	file := MREFile new
		        path: 'test.java';
		        content: fileContent.

	location1 := { (#textRange -> textRange) } asDictionary.
	location2 := { (#textRange -> textRange) } asDictionary.

	issue := {
		         (#textRange -> textRange).

		         (#flows -> {
			          { (#locations -> { location1 }) } asDictionary.
			          { (#locations -> { location2 }) } asDictionary }).
					#message -> message }
		         asDictionary.

	sonarHelper := MRESonarqubeHelper new.

	violation := sonarHelper
		             parseIssueIntoViolation: issue
		             ofRule: rule
		             inFile: file.

	self assert: violation rule equals: rule.
	self assert: violation rule description equals: message.

	expectedEntity := sonarHelper
		                  parseTextRangeIntoEntity: textRange
		                  ofFile: file.

	violation entities do: [ :entity |
		self assert: entity file equals: expectedEntity file.
		self assert: entity startPos equals: expectedEntity startPos.
		self assert: entity endPos equals: expectedEntity endPos.
		self assert: entity model equals: expectedEntity model ]
]

{ #category : #tests }
MRESonarqubeHelperTest >> testParseTextRangeIntoEntityOfFile [

	| sonarqubeHelper file entity model fileContent textRangeClass |
	sonarqubeHelper := MRESonarqubeHelper new.

	fileContent := 'class Java {}'.
	file := MREFile new
		        path: 'test.java';
		        content: fileContent.

	model := MREParser new parse: file.
	file model: model.

	textRangeClass := {
		                  (#startLine -> 1).
		                  (#startOffset -> 0).
		                  (#endLine -> 1).
		                  (#endOffset -> fileContent size) } asDictionary.

	entity := sonarqubeHelper
		          parseTextRangeIntoEntity: textRangeClass
		          ofFile: file.

	self assert: entity file equals: file.
	self
		assert: entity startPos
		equals: (textRangeClass at: #startOffset) + 1.
	self assert: entity endPos equals: (textRangeClass at: #endOffset).
]

{ #category : #tests }
MRESonarqubeHelperTest >> testParseTextRangeIntoEntityOfFileIfEntityNotFoundInModel [

	| sonarqubeHelper file entity model |
	sonarqubeHelper := MRESonarqubeHelper new.


	file := MREFile new
		        path: 'test.java';
		        content: 'class Java {}'.

	model := MREParser new parse: file.
	file model: model.

	entity := sonarqubeHelper
		          parseTextRangeIntoEntity: textRange
		          ofFile: file.

	self assert: entity file equals: file.
	self assert: entity startPos equals: (textRange at: #startOffset) + 1.
	self assert: entity endPos equals: (textRange at: #endOffset).
	self assert: entity model isNil
]

{ #category : #tests }
MRESonarqubeHelperTest >> testParseTextRangeIntoEntityOfFileIfModelNil [

	| sonarqubeHelper file entity |
	sonarqubeHelper := MRESonarqubeHelper new.

	file := MREFile new
		        path: 'test.java';
		        content: 'class Java {}'.

	entity := sonarqubeHelper
		          parseTextRangeIntoEntity: textRange
		          ofFile: file.

	self assert: entity file equals: file.
	self assert: entity startPos equals: (textRange at: #startOffset) + 1.
	self assert: entity endPos equals: (textRange at: #endOffset).
	self assert: entity model isNil
]

{ #category : #tests }
MRESonarqubeHelperTest >> testViolationsInMergeRequestOfInFileUsingRuleId [

	| mergeRequestId rule file ruleId helper violations projectKey sonarqubeApi issue1 issue2 params expectedEntity |
	mergeRequestId := 1.
	rule := MRERule new.
	file := MREFile new
		        path: 'test.ts';
		        content: 'class Java {}'.
	ruleId := 'java:1111'.
	projectKey := 'projectKey'.

	sonarqubeApi := SonarAPIMock new.

	issue1 := {
		          (#textRange -> textRange).
		          (#status -> 'OPEN').
		          (#flows -> {  }).
		          (#message -> 'message') } asDictionary.

	issue2 := {
		          (#textRange -> textRange).
		          (#status -> 'CLOSE').
		          (#flows -> {  }).
		          (#message -> 'message') } asDictionary.

	params := {
		          (#componentKeys -> (projectKey , ':' , file path)).
		          (#pullRequest -> mergeRequestId).
		          (#rules -> ruleId) } asDictionary.

	(sonarqubeApi issues stub searchWithParams: params) willReturn: {
			issue1.
			issue2 }.

	helper := MRESonarqubeHelper new
		          mergeRequestId: 1;
		          type: 'mergeRequest';
		          projectKey: projectKey;
		          sonarqubeApi: sonarqubeApi.

	violations := helper
		              violationsInMergeRequestOf: rule
		              inFile: file
		              usingRuleId: ruleId.

	self assert: violations size equals: 1.
	self assert: violations first rule equals: rule.

	expectedEntity := helper
		                  parseTextRangeIntoEntity: textRange
		                  ofFile: file.

	violations first entities do: [ :entity |
		self assert: entity file equals: expectedEntity file.
		self assert: entity startPos equals: expectedEntity startPos.
		self assert: entity endPos equals: expectedEntity endPos.
		self assert: entity model equals: expectedEntity model ]
]

{ #category : #tests }
MRESonarqubeHelperTest >> testViolationsOfInFileUsingRuleId [

	| mergeRequestId rule file ruleId helper violations projectKey violation entity |
	mergeRequestId := 1.
	rule := MRERule new.
	file := MREFile new path: 'test.ts'.
	ruleId := 'java:1111'.
	projectKey := 'projectKey'.



	helper := MRESonarqubeHelper new
		          mergeRequestId: 1;
		          type: 'mergeRequest';
		          projectKey: projectKey.

	entity := MREEntity new file: file; startPos: 1; endPos: 5.

	violation := MREViolation new
		             rule: rule;
		             addEntity: entity.

	(helper stub
		 violationsInMergeRequestOf: rule
		 inFile: file
		 usingRuleId: ruleId) willReturn: { violation }.

	violations := helper
		              violationsOf: rule
		              inFile: file
		              usingRuleId: ruleId.

	self assert: violations size equals: 1.
	self assert: violations first rule equals: rule.

	self
		assertCollection: violations first entities
		hasSameElements: { entity }
]

{ #category : #tests }
MRESonarqubeHelperTest >> testViolationsOfInFileUsingRuleIdIfAll [

	| mergeRequestId rule file ruleId helper violations projectKey violation entity |
	mergeRequestId := 1.
	rule := MRERule new.
	file := MREFile new path: 'test.ts'.
	ruleId := 'java:1111'.
	projectKey := 'projectKey'.



	helper := MRESonarqubeHelper new
		          mergeRequestId: 1;
		          type: 'all';
		          projectKey: projectKey.

	entity := MREEntity new
		          file: file;
		          startPos: 1;
		          endPos: 5.

	violation := MREViolation new
		             rule: rule;
		             addEntity: entity.

	(helper stub
		 allViolationsOf: rule inFile: file usingRuleId: ruleId) willReturn: { violation }.

	violations := helper
		              violationsOf: rule
		              inFile: file
		              usingRuleId: ruleId.

	self assert: violations size equals: 1.
	self assert: violations first rule equals: rule.

	self
		assertCollection: violations first entities
		hasSameElements: { entity }
]
