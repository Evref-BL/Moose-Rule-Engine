"
I verify preset inheritance, ordered rule deduplication, fresh rule instances, unknown preset failures, and inheritance cycle detection.
"
Class {
	#name : 'MRERulePresetResolverTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'tests' }
MRERulePresetResolverTest >> testAddRuleNamesFromPresetNamed [

	| resolver |
	resolver := MRERulePresetResolver new.
	resolver ruleNamesForPresetNames: #(  ).

	self assert: (resolver addRuleNamesFromPresetNamed: 'mre-test-child') equals: resolver
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testErrorUnknownPresetNamed [

	| resolver |
	resolver := MRERulePresetResolver new.
	resolver ruleNamesForPresetNames: #(  ).

	self should: [ resolver errorUnknownPresetNamed: 'missing' ] raise: Error
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testInitialize [

	| resolver |
	resolver := MRERulePresetResolver new.

	self assert: (resolver ruleNamesForPresetNames: #(  )) isEmpty
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRegisteredPresetsByName [

	| resolver presets |
	resolver := MRERulePresetResolver new.
	presets := resolver registeredPresetsByName.

	self assert: (presets includesKey: 'mre-test-child')
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testResolveRuleClassesForPresetNames [

	| resolver |
	resolver := MRERulePresetResolver new.

	self assert: (resolver resolveRuleClassesForPresetNames: #( 'mre-test-child' )) equals: {
			MRETestRuleOne.
			MRETestRuleTwo }
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleClassNamed [

	| resolver |
	resolver := MRERulePresetResolver new.

	self assert: (resolver ruleClassNamed: 'MRETestRuleOne') equals: MRETestRuleOne
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleClassNamedUnknownRule [

	| resolver |
	resolver := MRERulePresetResolver new.

	self should: [ resolver ruleClassNamed: 'MissingRule' ] raise: Error
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleClassesForPresetNames [

	self assert: (MRERulePresetResolver ruleClassesForPresetNames: #(  )) isEmpty
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleClassesForPresetNamesCyclicInheritanceRaisesError [

	self should: [ MRERulePresetResolver ruleClassesForPresetNames: #( 'mre-test-cycle-a' ) ] raise: Error
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleClassesForPresetNamesResolvesParentsBeforeChildAndRemovesDuplicates [

	| ruleClasses |
	ruleClasses := MRERulePresetResolver ruleClassesForPresetNames: #( 'mre-test-child' ).

	self assert: ruleClasses equals: {
			MRETestRuleOne.
			MRETestRuleTwo }
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleClassesForPresetNamesUnknownPresetRaisesError [

	self should: [ MRERulePresetResolver ruleClassesForPresetNames: #( 'missing' ) ] raise: Error
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRuleNamesForPresetNames [

	| resolver |
	resolver := MRERulePresetResolver new.

	self
		assert: (resolver ruleNamesForPresetNames: #( 'mre-test-child' ))
		equals: (OrderedCollection with: 'MRETestRuleOne' with: 'MRETestRuleTwo')
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testRulesForPresetNamesCreatesFreshRuleInstances [

	| firstResolution secondResolution |
	firstResolution := MRERulePresetResolver rulesForPresetNames: #( 'mre-test-child' ).
	secondResolution := MRERulePresetResolver rulesForPresetNames: #( 'mre-test-child' ).

	self deny: firstResolution first identicalTo: secondResolution first
]
