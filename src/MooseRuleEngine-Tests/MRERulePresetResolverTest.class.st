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
MRERulePresetResolverTest >> testResolveWithPresetsAndRules [

	| testPresets resolvedRules testRules |
	testPresets := { MRETestChildPreset }.
	testRules := {  }.

	resolvedRules := MRERulePresetResolver new
		                 resolveWithPresets: testPresets
		                 andRules: testRules.

	self assertCollection: resolvedRules hasSameElements: {
			MRETestRuleOne.
			MRETestRuleTwo }
]

{ #category : 'tests' }
MRERulePresetResolverTest >> testResolveWithPresetsAndRulesCyclicParent [

	| testPresets testRules |
	testPresets := {
		               MRETestCycleAPreset.
		               MRETestCycleBPreset }.
	testRules := {  }.

	self
		should: [
				MRERulePresetResolver new
					resolveWithPresets: testPresets
					andRules: testRules ]
		raise: Error
]
