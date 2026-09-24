Class {
	#name : 'MRETestCycleAPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestCycleAPreset class >> parentPresetNames [

	^ #( 'mre-test-cycle-b' )
]

{ #category : 'accessing' }
MRETestCycleAPreset class >> presetName [

	^ 'mre-test-cycle-a'
]
