"
I verify preset inheritance, ordered rule deduplication, fresh rule instances, unknown preset failures, and inheritance cycle detection.
"
Class {
	#name : 'MRERulePresetTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'tests' }
MRERulePresetTest >> testCreatesFreshRuleInstances [

	| firstResolution secondResolution |
	firstResolution := MRERulePresetResolver rulesForPresetNames: #( 'mre-test-child' ).
	secondResolution := MRERulePresetResolver rulesForPresetNames: #( 'mre-test-child' ).

	self deny: firstResolution first identicalTo: secondResolution first
]

{ #category : 'tests' }
MRERulePresetTest >> testCyclicInheritanceRaisesError [

	self should: [ MRERulePresetResolver ruleClassesForPresetNames: #( 'mre-test-cycle-a' ) ] raise: Error
]

{ #category : 'tests' }
MRERulePresetTest >> testResolvesParentsBeforeChildAndRemovesDuplicates [

	| ruleClasses |
	ruleClasses := MRERulePresetResolver ruleClassesForPresetNames: #( 'mre-test-child' ).

	self assert: ruleClasses equals: {
			MRETestRuleOne.
			MRETestRuleTwo }
]

{ #category : 'tests' }
MRERulePresetTest >> testUnknownPresetRaisesError [

	self should: [ MRERulePresetResolver ruleClassesForPresetNames: #( 'missing' ) ] raise: Error
]
